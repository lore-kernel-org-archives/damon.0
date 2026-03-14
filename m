Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24C239E9A;
	Sat, 14 Mar 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773505548; cv=none; b=Ueao8r//06VGZm96rMW5+OarI0w3kGQ0cT2ClYFZXWZHTn3Dk6y1mQVNnI1xUKKWHS4NcxFwqwhgVA+1tWc5FBly0KO69vKUrKrMpJLeW9vGCuCDDsn4C/36jokYAN4sihM2ruxb+iyd6poD7LULel8pX34dXeJexo0FgCwJGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773505548; c=relaxed/simple;
	bh=WQHjrscJNWdfNTnaiIwZRdE72Obs+ZCkgeJJYYAS6KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oda+RjhHC/YU0KQrI0rDfvqnJusHfHFaOX9dFbxIA5YIzws/DhMIqv7SF1QwHt1LPXdgRFeTakXNh6whMSvuX/Ewbc9E6jVVPhSjOahRoCoWNXI4781SIxswUWQd6LJsmMKbIxYCbXuKITqvdpVUaEtnTOep/HaEklP3a8vd1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu18mppS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu18mppS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B431AC116C6;
	Sat, 14 Mar 2026 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773505547;
	bh=WQHjrscJNWdfNTnaiIwZRdE72Obs+ZCkgeJJYYAS6KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tu18mppSLudEvM5OC7BNvQCYIEE2FB4FQPoRK3PXyJjh/ziHxprozbZ7kkI0WafyG
	 k3yewUuiW1Go3jboIU6p+FCJkmXKUgtWD69vcP6JSNlWaI06JrYGb77qng8PgRdUUz
	 dZRY7BcNI3lSxsj6h33MSlVMlkjl7so1GwPpxtCZt8WeXQ+ptHn42PzCTahICEDm7S
	 90txMgKW7wFGVoZyCr+3IRqDb134wqplPTD+DchY1YNC1HDCzPwwf/wgts68kqyXIk
	 PCMw5g1XPDVnJldy2c1Bp3IYg0ILzUWuCMbcd1ihl/wYiPBL8kcmteIeyl9xkA3p1p
	 DXqu8t7NDwUkA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Docs/mm/damon: document exclusivity of special-purpose modules
Date: Sat, 14 Mar 2026 09:25:45 -0700
Message-ID: <20260314162546.86404-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314092145.7496-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,

On Sat, 14 Mar 2026 17:20:22 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Add a section in design.rst to explain that DAMON special-purpose kernel
> modules (LRU_SORT, RECLAIM, STAT) run in an exclusive manner and return
> -EBUSY if another is already running.
> 
> Update lru_sort.rst, reclaim.rst and stat.rst by adding cross-references
> to this exclusivity rule at the end of their respective Example
> sections.

Thank you for doing this!

> 
> While at it, fix a Sphinx syntax error in the "contents" directive in
> design.rst (missing space after :depth:) that prevents the table of
> contents from being rendered on docs.kernel.org.

And thank you for fixing this!  But, the broken "contents" directive is added
by a commit on damon/next tree [1] that not yet planned to be upstreamed.  That
is, seems this patch is based on damon/next tree.  As a result, this patch
cannot be cleanly applied on mm-new.  We prefer making patches based on mm-new
unless there is a reason.

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Link: https://lore.kernel.org/damon/20260314002119.79742-1-sj@kernel.org/T/#t

I think it would be nice to give a context about the link.

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>

Assuming you agree to my above suggestions, I added this patch to the top area
of damon/next after dropping the "contents" directive fix and adding a simple
sentence describing the context of the link.  The change made to this patch for
that is as below.  If you don't mind, I will post it as v2 of this patch by
tomorrow morning in Pacific Time.  Please let me know if you have any comments
about the plan.

'''
diff --git a/Docs-mm-damon-document-exclusivity-of-special-purpos.patch b/Docs-mm-damon-document-exclusivity-of-special-purpos.patch
index 9e74de3b..db466405 100644
--- a/Docs-mm-damon-document-exclusivity-of-special-purpos.patch
+++ b/Docs-mm-damon-document-exclusivity-of-special-purpos.patch
@@ -11,26 +11,31 @@ Update lru_sort.rst, reclaim.rst and stat.rst by adding cross-references
 to this exclusivity rule at the end of their respective Example
 sections.
 
-While at it, fix a Sphinx syntax error in the "contents" directive in
-design.rst (missing space after :depth:) that prevents the table of
-contents from being rendered on docs.kernel.org.
+This change is motivated from another discussion [1].
+
+[1] https://lore.kernel.org/damon/20260314002119.79742-1-sj@kernel.org/T/#t
+
+TODO: move below changelog to the comment section when posting
+Change from v1
+(https://lore.kernel.org/20260314092145.7496-1-aethernet65535@gmail.com)
+- Drop contents directive fix
+- Reword description
 
-Link: https://patch.msgid.link/20260314092145.7496-1-aethernet65535@gmail.com
 Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
-Link: https://lore.kernel.org/damon/20260314002119.79742-1-sj@kernel.org/T/#t
+Reviewed-by: SeongJae Park <sj@kernel.org>
 Signed-off-by: SeongJae Park <sj@kernel.org>
 ---
  Documentation/admin-guide/mm/damon/lru_sort.rst | 5 +++++
  Documentation/admin-guide/mm/damon/reclaim.rst  | 5 +++++
  Documentation/admin-guide/mm/damon/stat.rst     | 5 +++++
- Documentation/mm/damon/design.rst               | 6 +++++-
- 4 files changed, 20 insertions(+), 1 deletion(-)
+ Documentation/mm/damon/design.rst               | 4 ++++
+ 4 files changed, 19 insertions(+)
 
 diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
-index 06a46812a728c..0198dfe87f4d5 100644
+index 73980bacc3a02..56690646cf398 100644
 --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
 +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
-@@ -353,3 +353,8 @@ the LRU-list based page granularity reclamation. ::
+@@ -351,3 +351,8 @@ the LRU-list based page granularity reclamation. ::
      # echo 400 > wmarks_mid
      # echo 200 > wmarks_low
      # echo Y > enabled
@@ -40,10 +45,10 @@ index 06a46812a728c..0198dfe87f4d5 100644
 +purpose modules exclusivity <damon_design_special_purpose_modules_exclusivity>`
 +for more details.
 diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
-index c5b4d8a1b0014..a37ce6fdff050 100644
+index 552a7786b0829..6f580f637134a 100644
 --- a/Documentation/admin-guide/mm/damon/reclaim.rst
 +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
-@@ -331,6 +331,11 @@ granularity reclamation. ::
+@@ -318,6 +318,11 @@ granularity reclamation. ::
      # echo 200 > wmarks_low
      # echo Y > enabled
  
@@ -56,7 +61,7 @@ index c5b4d8a1b0014..a37ce6fdff050 100644
  .. [2] https://lwn.net/Articles/787611/
  .. [3] Documentation/mm/free_page_reporting.rst
 diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
-index 468c122c42594..46c5dd96aa2ed 100644
+index e5a5a2c4f803a..c4b14daeb2dd6 100644
 --- a/Documentation/admin-guide/mm/damon/stat.rst
 +++ b/Documentation/admin-guide/mm/damon/stat.rst
 @@ -45,6 +45,11 @@ You can enable DAMON_STAT by setting the value of this parameter as ``Y``.
@@ -72,19 +77,10 @@ index 468c122c42594..46c5dd96aa2ed 100644
  
  aggr_interval_us
 diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
-index 0a3b77ec458fe..3694c541e65aa 100644
+index 29fff20b3c2a9..dc37402c0fee9 100644
 --- a/Documentation/mm/damon/design.rst
 +++ b/Documentation/mm/damon/design.rst
-@@ -5,7 +5,7 @@ Design
- ======
- 
- .. contents:: :local:
--   :depth:2
-+   :depth: 2
- 
- .. _damon_design_execution_model_and_data_structures:
- 
-@@ -960,6 +960,10 @@ more detail, please read the usage documents for those
+@@ -853,6 +853,10 @@ more detail, please read the usage documents for those
  (:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim` and
  :doc:`/admin-guide/mm/damon/lru_sort`).
'''  

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
