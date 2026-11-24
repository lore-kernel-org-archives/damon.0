Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536092;
	b=h0o9bLOQjrpUFQbK76dVQMluwOyl3CGk3FFCxDyGBR10mjlKdeEDOFROmEKg3jCSvZ5A
	 U43dbkqw35TAztXypUWToWXlSZ9SPkYL9jX4+RxjGfdSv++DFXBdf1jBIPDvpeX7U+uqc
	 vQD/jH1T4muazMCZrduRCslelSaTJXAiRjRKIkLOK33+pPHS8ygB6O8vvJFHu/Wlkbd9e
	 nYqzZjnh42FFmO2+q4Dizl64ZjcbmxH/rqz2SQ67ZnC64leQ3iw6fpDTB0MkXGFRn2+aX
	 RJqFxFBziTK9ic/JIU+tNBT3VdZfZjIbJRfw0Yuf1Pxrzh/LKLbeIVs74HrCDgB5xKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536092;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q9AzOcx7lT/GAxuFckU0BqUnqN5Gf6MdjD8AIDI3n7g=;
	b=T3IK1iMyPB8EDU/JudRbCf3coBRsSHT21cTkUK5GtOYmt60MiBX80Zkgcvk3zDWmyOY7
	 vnZVSOgb+57Od6MalPzh1QWAAOy5UczzFtp7fohM/XwubZ5eZ9Fu3mrhUZH6gUrHg8+4N
	 8/4hTZrKmeQ0sPzmB9x/Tog2XG2sAe3sa6S3TZB8cx5uC2Y5Uis6KqpzTsN3UXJPua+c5
	 CCf/dygBEBEfSeOb65aw55quq/OPoODUNueOkiycFBLa0N6NzTYXe08qMFLxd2ODprOtk
	 xZf77RKMVc6dSpxes74c4jK1s49L59RKiYYfCjS+4vC5mhm9trY4qXyQPQcRdHro43A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyKVdbNh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAC606A31E;
	Tue, 24 Nov 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyKVdbNh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEC31F000C6;
	Tue, 24 Nov 2026 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536091;
	bh=q9AzOcx7lT/GAxuFckU0BqUnqN5Gf6MdjD8AIDI3n7g=;
	h=From:To:Cc:Subject:Date;
	b=VyKVdbNhhNwvY2U4T2D2HYlO9FeOrSAMOP7NjSY3IrbQntMzm6T+dbybYTGx7ypXk
	 4dsrslN9SyjdilOwkCNyJ2RCjmzOLD3EInnSHJNZwPi4XfOpvLO6TGpDi2xJqhzFGX
	 Ay7K9jIKM5abcBUIv4JRAxeQ3yfuJw+9X9tWsfQrlEYRywpCZ/wYokMOyp1y6pCrMt
	 Dgwy1S8FQIXk/lCcr8ehMcK/e6ncqN6pA6JLTmBjcuT3Ue20/RoGLGqFNB365nvlBA
	 vB0wv5xyLi0cEFXRO8Jqm7lANlFV8vzZPDlyutxmtC1xsjmFQbTaxEfTecgEvGfTbb
	 kLD8UKERnHgwQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-new 0/4] mm/damon: update documents for mm-next onboarding
Date: Tue, 24 Nov 2026 08:01:18 -0800
Message-ID: <20261124160124.93482-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right after the 7.5-rc1 release, DAMON will onboard the mm-next
transition [1].  The major change is that it will use mm/damon.git [2]
and mm/linux.git [3] instead of sj/linux.git [4] and akpm/mm.git [5].

Update MAINTAINERS file to capture the change, via patch 1.  Further
update DAMON maintainer-profile document for the change, step by step,
via patches 2-4.

[1] https://lore.kernel.org/bed81e01-7303-4957-bd7d-38e3a094e96f@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mm/damon.git/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/mm/linux.git/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/

Changes from RFC
- RFC: https://lore.kernel.org/20261121193331.108587-1-sj@kernel.org
- Update patch 2 commit message for DAMON section name update.
- Rebase to the latest mm-new.

Huge thanks to Andrew for his tremendous mm.git works that raised DAMON
up to the current state.

SJ Park (4):
  MAINTAINERS: change DAMON SCM tree to mm/damon.git
  Docs/mm/damon/maintainer-profile: use damon.git for patch baselines
  Docs/mm/damon/maintainer-profile: drop 'SCM Trees' section
  Docs/mm/damon/maintainer-profile: update key cycle dates for damon.git

 Documentation/mm/damon/maintainer-profile.rst | 57 ++++++++++---------
 MAINTAINERS                                   | 36 ++++++------
 2 files changed, 46 insertions(+), 47 deletions(-)


base-commit: 39902b38a4f121b7b3c847622585858cc8070c97
-- 
2.47.3
