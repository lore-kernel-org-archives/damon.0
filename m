Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750F224B04;
	Sun, 29 Mar 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798256; cv=none; b=sf0XBn3i1PaD5FZY049rugJECxsMAxHhgkUpS4u5CUB2HobfMeBgu4piYuyd/j6PHRe93xyRoYngFBJC2R6zQ7dxB3LwvPvFu9GB4unur1GHMUs0N5AZK1i9d5p4w60fLbARmgL/Ftyte4MwlVhRuNZPs53BQujwWBnXTvKy2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798256; c=relaxed/simple;
	bh=+Vuu7wt+nGQlkJXcCrqmt/j27FT/vMyHTCViEQGR7sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mh5oS9eWTNM74WK4rWtDout7Q9z/ms41CBFN1ZcJWJLXl7EGQfbjOVAm+c18jjLOG42+i16u5acxhPUZGatz8FOQ0JvOw/zgSuzvb9WsDC5lzY9nSImk902WR72jDZ0QwKxr42uP7RwJfX1w391tuXGlQB6CAI8pQ5Yg9mQvWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJwtZg9K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJwtZg9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96FFC2BCB3;
	Sun, 29 Mar 2026 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774798256;
	bh=+Vuu7wt+nGQlkJXcCrqmt/j27FT/vMyHTCViEQGR7sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJwtZg9K6U4VRZ0r2hlAY4XFRHBLim8dZ/Xvik762PO5eROJ4vVAY9eAhyBbz/arI
	 fMNisW/OZZtsGuS9o4D0frWt10QP53N1BN5Q4SEBaNDZGkGG1Qhh9ld9HMIgwTfEVm
	 gXwMWoTAWLeNfUOrOGwiKQxfGe1V2XhIPTGtie1eqtZled6tHQ5dtNw8O5PkZERXRM
	 +LoRLFaXC2WmsT9uL+1kq/xXSiNhPl4XrXTRnS/F74XtW7U/6Jrdalc3kFyu3MVr22
	 FfoS9cngIU+CD0ELQ6BPlPa1Vqm6fPZUJEZkcj5WBOypnC5edUUALCtzWVnvhGrvHu
	 9YVJiIH8X0eTA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
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
Subject: [PATCH 1/2] Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
Date: Sun, 29 Mar 2026 08:30:49 -0700
Message-ID: <20260329153052.46657-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329153052.46657-1-sj@kernel.org>
References: <20260329153052.46657-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM handles commit_inputs request inside kdamond thread,
reading the module parameters.  If the user updates the module
parameters while the kdamond thread is reading those, races can happen.
To avoid this, the commit_inputs parameter shows whether it is still in
the progress, assuming users wouldn't update parameters in the middle of
the work.  Some users might ignore that.  Add a warning about the
behavior.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260319161620.189392-3-objecting@objecting.org

Fixes: 81a84182c343 ("Docs/admin-guide/mm/damon/reclaim: document 'commit_inputs' parameter")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index a100216f3a72..17e938c319e3 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -71,6 +71,10 @@ of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
+Once ``Y`` is written to this parameter, the user must not write to any
+parameters until reading ``commit_inputs`` again returns ``N``.  If users
+violate this rule, the kernel may exhibit undefined behavior.
+
 min_age
 -------
 
-- 
2.47.3
