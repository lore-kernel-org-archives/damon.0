Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483C322A2E;
	Mon,  8 Dec 2025 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175440; cv=none; b=fN/Uq8DLZXw95+Fy7n1JFBf25bKFNNpmZFSXArgOZ+VOFXFzU8njduvCTKk/KCgHNTl5C1GFmxME43XJrhA6Fljc4Z0XiFut7fN6x0ZGzvtqmyWnd50QARZB2SGvrOuzAitkTJhXB3KrAvi0vk9awvaw4lC/uvGjF2Ax7ghj4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175440; c=relaxed/simple;
	bh=P2SgdyCf2ZU0vqy/RDrIyCr5Bu1z5InvNin3lNvOuEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJBWH6RIyErEZYVqMumR210GVIgLzbzTe9nrSRWbnUJGcXaChAglY730EyxU8UhPBhOvg1RwrTGInn2nPS4txuIoZAKH6Jbj6mLZlTMODUsFj/6BuNL316zXCcTT1fhFtTL6dkZBiLgZ2YrLSi6hZdAB3JfJUPQCYfcTmk3Q7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StSBOZTR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StSBOZTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB2EC19421;
	Mon,  8 Dec 2025 06:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175439;
	bh=P2SgdyCf2ZU0vqy/RDrIyCr5Bu1z5InvNin3lNvOuEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StSBOZTRBdXApkEJVKfwmFrboFQjqC8MYLknLXOmdgrtgFNEfFPug4wod06n0TzlM
	 Y8QuzC0Gq3JOT8dUBFwR6Qx9y0F0KrPfAEY8XUYd5nDDcbx6V+3Q4fBnP74VG8Pr/F
	 lYTrYA1aiL0qrEx8xfvE5IWHjMD99J/QzETrf9oANE9uBVsuWecK6XBCmzxXxAyFZt
	 r8OCoBqkIhk+XAcaktUDsn9HHy7dF3X4pAW0aLtPYLd8QVy6OwbWaEAeCEKI4XkqiD
	 n8qkFLT/O1CemZfo1ng1PzlIz8YzOFy6N78a4vhQhnO0in7P1mRNOhmEXqhg3laGLb
	 EwcNqZHFCo6xQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 32/37] Docs/admin-guide/mm/damon/usage: document tids_arr file
Date: Sun,  7 Dec 2025 22:29:36 -0800
Message-ID: <20251208062943.68824-33-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the threads based access sampling
results filtering.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 365a4548a5ba..d22d80710355 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -67,7 +67,7 @@ comma (",").
     │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
     │ │ │ │ │ │ sample/primitives/page_table,page_faults
     │ │ │ │ │ │ sample/filters/nr_filters
-    │ │ │ │ │ │ │ 0/type,matching,allow,cpumask
+    │ │ │ │ │ │ │ 0/type,matching,allow,cpumask,tid_arr
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
     │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target
@@ -260,13 +260,14 @@ context, in the order of the directory names.  Writing ``0`` to ``nr_filters``
 removes the directories.
 
 Under the individual filter directory, five files, ``type``, ``matching``,
-``allow``, and ``cpumask`` exist.  The first three files are same to the
-properties of the filter specified on the :ref:`design doc
+``allow``, ``cpumask`` and ``tid_arr`` exist.  The first three files are same
+to the properties of the filter specified on the :ref:`design doc
 <damon_design_sampling_results_filters>`.
 
-Users can specify the cpumask of the filter by writing it to ``cpumask``.  The
-format for ``cpumask`` input is same to that for other cpumask inputs like that
-for cgroup cpusets.
+Users can specify the cpumask and thread id array of the filter by writing
+those to ``cpumask`` and ``tid_arr``.  The format for ``cpumask`` input is same
+to that for other cpumask inputs like that for cgroup cpusets.  For
+``tid_arr``, users can write array of the thread ids, separated by a comma.
 
 .. _damon_usage_sysfs_monitoring_intervals_goal:
 
-- 
2.47.3
