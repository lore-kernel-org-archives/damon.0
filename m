Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BA3D9DB0;
	Sun, 26 Jul 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087592; cv=none; b=rfzf+iBZ2h9Ywxo60x07i3myu5LxSIJ4kw49qaZ34Qs5kyb2y7Mg95qONXwtbjXRed3yv9BrfpxCSWtSjRE9yah8JHSNN4gq0Cf5JPInuKRmQjnQBvooLtI9CEBM26XZTxmf55IN7qVcwVw49/dSOQzrChwRZsfAhZFz7eQkhlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087592; c=relaxed/simple;
	bh=dHDby/6BRKxiNU32vg3qgdhmWYJ9rG6myzLRMzxCpXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjEMZnMOUacwMqWapUexSPxvcA/Rgs+UfTXslK9F8tNRUhEoSVuyXXruh79lvcs/NcIRDca+IM/B6wL/APMFuvQ/4wBVvkQ7/K+D0x5HewTi08xWgSuBsMs3xKzQYctDRLuwI/Ccmn4YuSLs7H0dOxImxxY/w437g4/Qa02LUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krq/lujb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krq/lujb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB8E1F00ADB;
	Sun, 26 Jul 2026 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087590;
	bh=htpcSL5YfmR1Mjx0E+Olyn+V4SI0oNH53BLn9HoIWZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Krq/lujbXIUaY/Wj1pPeEQTM6zQc6VbjxDk1ws6mDXAgWmggUUoX0SMj46ZMttTv1
	 RLqlzH9ami/F6h0cBXpgF7Keeo8O0yDKoSx4Qc/69bk2kIxJGR1BBjMaxFCxBgvTzR
	 REDM5MXg53VzYXc8HEYMqzA9ZH2ht4Euq1V2uC7GdlHZK4ObYIZhQdoBAGIkssNJ/P
	 WjMvXGGK+M+gWacd3nDe+3Hb1eDt7E3PEfU06Xb7FoC4pXfCVYJvWrOpF4Xitcsitb
	 B0Tu7yPHA9s7K5JD3Fpg9sIDekTZds1wo5f2pus9Qo7JussLEKz7/oY7pBMLHmaYKd
	 AokwUQArq+U/g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
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
Subject: [RFC PATCH v2 16/17] Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
Date: Sun, 26 Jul 2026 10:39:32 -0700
Message-ID: <20260726173935.94046-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added DAMON probe preps sysfs
files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index da5f9afd08aef..e4fdec3fa5059 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -74,6 +74,9 @@ comma (",").
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
     │ │ │ │ │ │ │ 0/weight
+    │ │ │ │ │ │ │ │ preps/nr_preps
+    │ │ │ │ │ │ │ │ │ 0/prep_action
+    │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ filters/nr_filters
     │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path
     │ │ │ │ │ │ │ │ │ ...
@@ -283,9 +286,18 @@ In the beginning, this directory has only one file, ``nr_probes``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each monitoring probe.
 
-In each probe directory, one directory, ``filters`` exists.  The directory
-contains files for installing filters for the probe, that is used to determine
-the data attribute for the probe.
+In each probe directory, two directories, ``preps`` and ``filters`` exist.  The
+directories contain files for installing probing preparation actions and
+filters for the probe, that is used to determine the data attribute for the
+probe.
+
+In the beginning, ``preps`` directory has only one file, ``nr_preps``.
+Writing a number (``N``) to the file creates the number of child directories
+names ``0`` to ``N-1``.  Each directory represents each preparation action.
+Each directory has one file, ``prep_action``.  The preparation action can be
+selected by writing the name of the action to the ``prep_action`` file.  Refer
+to the :ref:`design doc <damon_design_data_attrs_monitoring>` for the list of
+supported actions.
 
 Each probe directory also contains ``weight`` file.  Reading from and writing
 to the file gets and sets the :ref:`attributes-only monitoring
-- 
2.47.3
