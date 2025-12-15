Extension { #name : #Behavior }

{ #category : #'*GToolkit4Git' }
Behavior >> gtGitButtonFor: anAction [
	<gtClassAction>
	^ anAction button
		tooltip: 'Go to repository';
		priority: 4;
		icon: BrGlamorousVectorIcons branching;
		id: GtCoderGitButtonId;
		action: [ :aButton | 
			| coder |
			coder := aButton phlow firstParentCoder.
			coder navigationModel hasSelectedPackageOrClass
				ifTrue: [
					coder repository ifNil: [ 
						| gtRepo |
						gtRepo := (GtGitRepositoryRegistryHistory instance repositoryIncludingPackage: coder navigationModel selectedPackage name).
						gtRepo ifNotNil: [ aButton phlow spawnObject: gtRepo restore ] ].
					coder repository 
						ifNotNil: [ aButton phlow spawnTool: (GtGitPhlowTool new repository: coder repository) ]
						ifNil: [
							aButton phlow
									spawnTool: (GtPhlowExplicitTool new
											stencil: [ GtGitAddToRepositoryElement new package: coder navigationModel selectedPackage ]) ] ] ]
]
