Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54015C0;
	Thu,  2 Jan 2025 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844505; cv=none; b=P24kKWpFcsFdYxutkexoz1q7v8DQl6lDKmz9PgB7KVDcq3ouxlTYJp08Oso1M1zhyj5wIQ4ThIrt+PvvK47MSBwg/WHm1G6gPPgXSMvudXfpeAcTbZ+eza2iwqpNf+g+PfO5WL2V1xZTC/mhaBap6ZVQ5ryMNvJkBq+GLuEIM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844505; c=relaxed/simple;
	bh=lxc5tIE69MfMO8EJszX/Pb1Mmz8uhLOyqAs5NYo5ZMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q8bLpInff4aD9aZ8tKuNCWRKp4kXRjSPEK0+jeZKRqVXjcdLeQCasPB5OcYYIa2DM2fefLtZz6l3/DRicgh1VmX/dMqrfeg/8igvEhWcHnZy7xzIC7qD9xNSoZi8lS2MFALDUuKlTPIaXewPBKLTH9NGfy4dG779w3xFOafEw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFX8Id8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFX8Id8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9479C4CED0;
	Thu,  2 Jan 2025 19:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735844504;
	bh=lxc5tIE69MfMO8EJszX/Pb1Mmz8uhLOyqAs5NYo5ZMU=;
	h=From:To:Cc:Subject:Date:From;
	b=lFX8Id8RAuQLulbGXCE8Pvt4MRau670CEOxWnzTYmbD7uURD5uU9bGY51j3NgKPB2
	 0BC79/CoARImeRk5aM7SWKp5noMsRLHcRu1vox000TfpzBr8qZ5wRPCrl0BNUXGoWz
	 n82/bZtIbeikC3Ubz6CaCwGc68dZhOVwPsJ2fFLRJ80kbCiBwFm6EqlNR4wH4n9k6m
	 GuZX4GJnAPrIsTuxjP8RtLMUcUGx6mrYpobZ68wu48YdIupsH4DZuLHf0pkDFEOAHG
	 YLPvANu+4qu1Djkpnd/5NiCnSOER64Vw5KDSJ2dJu/zfMGohj2iXR9b5dSz32Ivrh8
	 KTJpUGcn25QdQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/5] Docs/mm/damon: add tuning guide and misc updates
Date: Thu,  2 Jan 2025 11:01:33 -0800
Message-Id: <20250102190138.47258-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DAMON monitoring parameters tuning guide, with misc documentation
fixes, clarifications and updates.

SeongJae Park (5):
  Docs/mm/damon/design: add monitoring parameters tuning guide
  Docs/mm/damon: add an example monitoring intervals tuning
  Docs/admin-guide/mm/damon/usage: fix and add missing DAMOS filter
    sysfs files on files hierarchy
  Docs/admin-guide/mm/damon/start: update snapshot example
  mm/damon: explain "effective quota" on kernel-doc comment

 Documentation/admin-guide/mm/damon/start.rst  |  67 +++--
 Documentation/admin-guide/mm/damon/usage.rst  |   2 +-
 Documentation/mm/damon/design.rst             |  57 ++++
 .../monitoring_intervals_tuning_example.rst   | 247 ++++++++++++++++++
 include/linux/damon.h                         |  13 +-
 5 files changed, 354 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/mm/damon/monitoring_intervals_tuning_example.rst

-- 
2.39.5
