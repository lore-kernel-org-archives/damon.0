Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C63E423E9A
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531218; cv=none; b=jv377OjoiQv8ov+qFOoF0rkQFkLZq7AN+b/yjMvjO85xMVE8AOTpK5XJcfg2ZCWc+fyajY7t+IjPcWszKUUIvdQCnkwpR6tVswAlKqQLkPR9XFvEVu0EWVSHAP22mOordSMIHhRa0cIEHrP7b9fHnO1CPmUSjGkbALE6qAJnHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531218; c=relaxed/simple;
	bh=2I+1B+A6lfClYXCgovEXx02WRIJ9oH5CQgeIM39TVAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jX86JHxGUsEksFlYbu+ZORGL/Z5BvkqDx2mQ3xgBOiuldQu1PFSl9caIZrlwpINnLlg4AaoH3vNjzQOMuMrInO3YAB6DeG6A7amqwrZip57Z5AkkHKo4eludHJfXiQc/dsiTsj1mgebm++v7cnL7/Bib8VEanKyhrX/lFOnSTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOAvadyk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOAvadyk"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1775103a91.0
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786531217; x=1787136017; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJ+Hxoz344ZJ6+13dkxOMiOcxZbShSOPZl6HyMgRs+M=;
        b=sOAvadykpW8IsLv9GfX1DZruktEwI4vL4Ae/peZLtww86GoA4Bmt7OxKxuL5PVrKVO
         SCba2vEGJ9OITWytVhMkSjAeulWHPA07UNBmKRB/prBhTPdvznhjjZwo1a10lUyWo2yI
         snrkEtU3uX5xFbHFvYhzkAKj2xjoXIV4Cg7c+Us9G4s8q2nAo9AJomiMdTOzcmZd8icB
         yjStmkcdjIXFtxydw4L7LXEGwlkGCKGypG+A3IjHO8vKuhAFq7rzn3+Zpm+DZMRoKles
         gCm8c3ZgkuIQTG/1AyWI22d4yaXm9BmNoZJBx+f0WuUeuURvzXlzItgiCPGnJf5wTtvf
         OiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786531217; x=1787136017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJ+Hxoz344ZJ6+13dkxOMiOcxZbShSOPZl6HyMgRs+M=;
        b=e6zOHqs2YNPzcC7mp2hARbptm3cFeV8LWfWt4nfTCr7B/TrIpcCRGcokV03jk7gLJD
         VTygU3VVYfTnOgxUFB3NKVsyahaznrS7ESC9i9BraORjEmt8iaBRoDzgB43c2siRE2kh
         Ot95Jx0Ru5jdlBay60PhCKJVagQMiOK6TsxGVYoSbQZvwUJ6siOwRKDZDczjIwM5XJdp
         nM4kodNVy6xPUX3mq5GZRLy3qlaOpEpT8Y8V9bFvmtsEZx4+7MaxB40oEPSuic5+D8YU
         gJ3o02S1aMiZe1BfiSWglgz8cLgKlON2loHN/P4PKV0ZWKlkX0pqZ/9yKMcNk5GBVJOQ
         sfPw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2x0P9lHuFfRrfVuh/wYYQJ4gwIavEtyngTcnfn05hwuyxe/vCPqc/PPQQhmqQtfNp0NFZqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7D5YjM7lQozn1fWYF9AcVzw6gomHLsnZJRv1mforYyq49EKxH
	FQbuLrULEGKpFybJbLtkAo9ruo1uoCoSATVNZ4XimSvD4IRBB208JueJ
X-Gm-Gg: AR+sD13QzWrGiQEpJpBNRgFUDcY6wQVlVLOLZhr/KeiCfZukJqrd0ePy1K6paNzHgdX
	GvZQSLZ5f0T8kaT4IVXRPz15fl6ClOKtvYXSM8DzpIfrwXv8GIcSSM2QFQOvuXrnsj2MLvRUamP
	kKpovN8EX+76BK4nu3iX5BLFTw13eF1QyLwgY4BPXLOspEFeiz5f/wBVOTyMQdmDgGVsTVAX6XH
	lSEqegmm05z1x8wKsi5A8Wz3Yql0AZI3tOO0G2+3lYdY6K8UTea/aqLvv1UG0mOuUcbfJCiCm1r
	OGHlT0sqZ0XISy/f3glnY0Ld13Pkiy2TjuABaD0PnfbaN5AGXq8fVv/N7BHP31BaJaHjnM4UCts
	qWaE4zDvD0sSQyZUNicWfox6yJw5p9FwFTUNF90z8Z2+KC7/ZkGXCyQQSH1/AHbX+abJSyGYGAJ
	0WFe0bhzmAzbCMZ4UoAahTAIbZyX/glyaFHH+M4zF7IEz25S62QHFG9szOe0AekTpQFX+JUChto
	+3L0vULQ5GZCF7jmZIJbrVRVQ==
X-Received: by 2002:a17:90b:5203:b0:38e:9784:dd47 with SMTP id 98e67ed59e1d1-392f3f08abdmr4412175a91.1.1786531216574;
        Wed, 12 Aug 2026 03:40:16 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3d0b432sm9931990eec.8.2026.08.12.03.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:40:16 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v2 3/3] docs/mm/damon/design: fix typo of max_nr_snapshots
Date: Wed, 12 Aug 2026 18:40:02 +0800
Message-ID: <20260812104002.15225-4-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104002.15225-1-aethernet65535@gmail.com>
References: <20260812104002.15225-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a typo (nr_snapshots -> max_nr_snapshots) and corrects a grammar
error.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 include/linux/damon.h             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index e7977f005ac0..d1dd9050ebf4 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -871,8 +871,8 @@ action is ``pageout`` while all pages of the region are unreclaimable, applying
 the action to the region will fail.
 
 Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
-non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
-scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
+non-zero and ``nr_snapshots`` equals or is greater than ``max_nr_snapshots``,
+the scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
 ``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
 
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
diff --git a/include/linux/damon.h b/include/linux/damon.h
index cbdf5f77978e..4b0d2d2e4ea4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -549,7 +549,7 @@ struct damos_migrate_dests {
  *
  * After applying the &action to each region, &stat is updated.
  *
- * If &max_nr_snapshots is set as non-zero and &stat.nr_snapshots be same to or
+ * If &max_nr_snapshots is set as non-zero and &stat.nr_snapshots equals or is
  * greater than it, the scheme is deactivated.
  */
 struct damos {
-- 
2.55.0

