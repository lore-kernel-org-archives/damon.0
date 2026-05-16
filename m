Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222335DA46;
	Sat, 16 May 2026 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956658; cv=none; b=Le+fhX3UkTL/14KJrfsUP+uuSBz9mk9qgcOLOONM8xbKWkGeNXnlfvZxnN2xCYJhOcM6MLxMNpo8XVdvbW5jLqGKZJBPCMdeiuqPoaFPo0QWVJLGW+viVYeMl062hQSwEvTF6qJLhgpE9TRCRetyJE2MM9AP4ai5gPtqkNitl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956658; c=relaxed/simple;
	bh=2ezmr596RCMSl8GJn5iaP7SQwY6FO5nwtQYKenA48Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBT0uUb2b0cZ2NU96x0/PcCIk+KFZn/0FZS1Rj7ojYIkLEXA2cMOc+faXKQ9xu6v/RklEHlo5Ca3KnsJPa4m364JNe7wTqPNZgDZhETd5xvwfKzHpV20bf5VNlDZAONnnFVBnB/4WLgUCa+c+XPlrE7GyS+vmW163Ap9UVrNgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEvgDpTH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEvgDpTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9452BC2BCF6;
	Sat, 16 May 2026 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956656;
	bh=2ezmr596RCMSl8GJn5iaP7SQwY6FO5nwtQYKenA48Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEvgDpTH3zyWW+YN6W72epS0dus/LicSC/g6uHpwevrjqMsjmJXObfl863R2HHT9b
	 miL3e7k5t/sewh13qlcBGSUdM2CapWSO4SChKv4AcOSbEyDyIdH5JKtV/+1RHjfruC
	 78nXdWXqDQ6PTM3vnR3rKdXxX29VNXbLZJB9YIDY1u8DHv+gNhskr8DYgyCk13nS6O
	 eWXFjn6jAXDtZThwLCd9hgqLtMK3y3o4NjjXyGG6/ynmbJ7a9dC97rN83TqX+jUIjb
	 OMYfwxFxxDrkuwE1tSgqslrSBMQSago0ixpzXe8ExzKa5bNWIIDK+MrleBvkAKAgBx
	 MeQSe21SJFK5g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 28/28] Docs/admin-guide/mm/damon/usage: update for memcg damon filter
Date: Sat, 16 May 2026 11:37:09 -0700
Message-ID: <20260516183712.81393-29-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added belonging memory cgroup
attribute monitoring feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 7b6074a1666f3..b4584c0e4cd72 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -73,7 +73,7 @@ comma (",").
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
     │ │ │ │ │ │ │ 0/filters/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,allow
+    │ │ │ │ │ │ │ │ 0/type,matching,allow,path
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
@@ -283,7 +283,9 @@ the data attribute for the probe.
 In the beginning, ``filters`` directory has only one file, ``nr_filters``.
 Writing a number (``N``) to the file creates the number of child directories
 named ``0`` to ``N-1``.  Each directory represents each filter and works in a
-way similar to that for :ref:`DAMOS filter <sysfs_filters>`.
+way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
+``type`` is ``memcg``, ``path`` file works the role of ``memcg_path`` for
+:ref:`DAMOS filter <sysfs_filters>`.
 
 .. _sysfs_targets:
 
-- 
2.47.3
