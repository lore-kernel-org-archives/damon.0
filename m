Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10502485CEE;
	Tue,  1 Sep 2026 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269122; cv=none; b=FFYhMlC78nVKkju+id1ymVgg2f4v44z9KhwIo/U6Zg/6jwoDdbez9FmorRjFfB+jHEOIiVWQNStZ0Zrwx2OcizuAkTLClErSCIdsLBGe0H+0vBrbSRSYx75MBrnWDFdjZDUWmBGTbIW04oxMVmrqedr2tr+frVK6f3kqHG8gNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269122; c=relaxed/simple;
	bh=g/tFPfelQzKUfzsRZPs73xHoniRK3oTmoDYddCctcSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShX+zB9aMqc/CnQlpURavUmJGHZZB3eswK6wCq5JIJm93IjDEYJ9DQ2ClLzc1K+U2ccuQ2t0HbXx1nS8Z1SdjTLJzkbK82enX+ClRYdpMEtoZfFFMAaHMzVzFAYDWxQxwxTUdtwwdZmZojv7JRmoaoNbqXq/O2XF7NfauQJ9UDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5I0h9Yk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5I0h9Yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1A01F0155E;
	Tue,  1 Sep 2026 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269120;
	bh=PjqVhtQyye+bbFZP93YpIQ5LAq+rT1MA3lQj7bnBnXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5I0h9YkcWnZ8KUsJyOrS3HjlUoaoJ2Yk4S9XxqPzPpXyZALfhmgP/WIwzm+GAZVa
	 eoB9euU1S3qUWKM8ZUvxY7a2IOg1Jw6y3+cvftZbfNYckT7fXQPrHsYvyW34sfq+dd
	 APfnCv9D1WbEHHik0KR7DzEHr2ttw43xhczb6uuNUa2ZWuX/iiKKRcglmxpGB39eL1
	 2xxV8wWWbtu5bWSUno0jNGfTnOp43Oj1HHsKQA9+i4lEkfwcmPIhJUGyL9/PLlF5wP
	 rYozQAUGOh0hDVgE+5MUbWINY4hUVA2NMaMnLcoxDtYYhN5QpoUBwAJma8sX2LpiQk
	 9jNRhfcjue3zw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 16/17] Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
Date: Tue,  1 Sep 2026 06:25:03 -0700
Message-ID: <20260901132506.99243-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
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
index da5f9afd08aef..023c6334024f8 100644
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
+filters for the probe, that are used to determine the data attribute for the
+probe.
+
+In the beginning, ``preps`` directory has only one file, ``nr_preps``.
+Writing a number (``N``) to the file creates the number of child directories
+named ``0`` to ``N-1``.  Each directory represents each preparation action.
+Each directory has one file, ``prep_action``.  The preparation action can be
+selected by writing the name of the action to the ``prep_action`` file.  Refer
+to the :ref:`design doc <damon_design_data_attrs_monitoring>` for the list of
+supported actions.
 
 Each probe directory also contains ``weight`` file.  Reading from and writing
 to the file gets and sets the :ref:`attributes-only monitoring
-- 
2.47.3
