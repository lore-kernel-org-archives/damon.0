Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466517BB0E;
	Tue, 18 Jun 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746595; cv=none; b=WrqIT+IFePlv365+lZxwUBsJBPeSyf9HKXywo0usZUBaNeBm7o6wzs4eJ6W5L1bfFbTobPx9Ddi69ZWs8pmg+KXnxc/NMhpnZltuINAp5JaiLnNfFZxofV+z3Z7Pi3JOfzR8rjxUcGGE/V5n9C23IRuHy0eY/fN2TnjEAioxekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746595; c=relaxed/simple;
	bh=RoniSjozDPpNLveGjBTMTaM+FpRJleaCmjKB3DAhfkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Em8hQhIHNmfSz2LukbhGceBq6KiO1z0IOBCjgo1kqULCIJu+XdJBfr+ghjBYlbp2yMPKZ0Ee9mA8QxjpWUijpqjzMhkuwNEhfBuEuGjMlxqrZ28ZIgrBCPBrdJaeCmfqG7lm6d+bbubs5f9t1OXicij7mAApUIGFs1IAv9PeBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p34/6GwW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p34/6GwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6171DC32786;
	Tue, 18 Jun 2024 21:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718746595;
	bh=RoniSjozDPpNLveGjBTMTaM+FpRJleaCmjKB3DAhfkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p34/6GwW02jnbVIkrWglFEBNA9oU35st/HdIpDUnsqKFAXtyVsobAiE3BWWnCTanb
	 9iwKlSYarqymTcntkYuSH5YzXhvFJZIxj1dzbfyTz8ZbAOXm2w5rdlqgwC76BXa2CS
	 tR5S2UPM2zHjMqXuslXQPkV7//M7DC1UkOdatIZ92iCVLEaJLaen5WJWkViEdyqo8y
	 FAqaZYqHyMGmb6BazBvENRcRMEfC9O2oix4j6wKL8LJbQA0j30mdFhP3AU+qogU7i/
	 pFyjljmz9dx5qbP5Hu3O80EN49resxDpV1j1bIyrUaPMyCAWTdqdTllUmUqlxrcorU
	 /k7tYkmjWS0TQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Honggyu Kim <honggyu.kim@sk.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Docs/admin-guide/damon/usage: trivial fixups for DAMOS_MIGRATE_{HOT,COLD} documetnation
Date: Tue, 18 Jun 2024 14:36:29 -0700
Message-Id: <20240618213630.84846-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618213630.84846-1-sj@kernel.org>
References: <20240618213630.84846-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixup below three trivial issues in DAMOS_MIGRATE_{HOT,COLD} usage
documentation[1,2].

1. Add target_nid on sysfs files hierarchy
2. Fix scheme directory section to mention target_nid file
3. Explain target_nid before apply_interval_us

Fixes: c100fc71858a ("Docs/damon: document damos_migrate_{hot,cold}") # mm-unstable [1]
Link: https://lore.kernel.org/20240614030010.751-8-honggyu.kim@sk.com # [2]
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 98804e34448b..26df6cfa4441 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -78,7 +78,7 @@ comma (",").
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`schemes <sysfs_schemes>`/nr_schemes
-    │ │ │ │ │ │ :ref:`0 <sysfs_scheme>`/action,apply_interval_us
+    │ │ │ │ │ │ :ref:`0 <sysfs_scheme>`/action,target_nid,apply_interval_us
     │ │ │ │ │ │ │ :ref:`access_pattern <sysfs_access_pattern>`/
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
@@ -289,21 +289,21 @@ schemes/<N>/
 ------------
 
 In each scheme directory, five directories (``access_pattern``, ``quotas``,
-``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and two files
-(``action`` and ``apply_interval``) exist.
+``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and three files
+(``action``, ``target_nid`` and ``apply_interval``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
 from the file and their meaning are same to those of the list on
 :ref:`design doc <damon_design_damos_action>`.
 
-The ``apply_interval_us`` file is for setting and getting the scheme's
-:ref:`apply_interval <damon_design_damos>` in microseconds.
-
 The ``target_nid`` file is for setting the migration target node, which is
 only meaningful when the ``action`` is either ``migrate_hot`` or
 ``migrate_cold``.
 
+The ``apply_interval_us`` file is for setting and getting the scheme's
+:ref:`apply_interval <damon_design_damos>` in microseconds.
+
 .. _sysfs_access_pattern:
 
 schemes/<N>/access_pattern/
-- 
2.39.2

