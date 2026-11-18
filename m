Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968559;
	b=SiozMacqdZ9pFS5BI2akeKkNJzIM6aDKgOIvWNEGlsnclZx0oTZQvLT23KstX5Ce/jvI
	 ab5DfPDgL9avGTdr6vWVtTA4KfKC55z6+Qo9jDhNpU7nfUGgwtRCs0eRaXaeLkaTXOhXM
	 6JoQDlS4SHPQCt4bPytpTYKzMEpXFz86zLNxepy8Ab7hVbE+cs0Ioe+tTVXHqy4CBLQSN
	 N5sXJWW1Zbp0tfKHpNoinVh1F32d6M5hj+avfUQsNfmYx8BSA5bIjgqGqA1dT3edfuiKs
	 L9u+FVXfsINuzgDCYfWnQm9uIcoV7ejEcDrsATqDnI+EMDltSRWQQ8MTCWtnr5OCuFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QzWAy5ljzbSA7LAk4a53ozwyTWaW9lGp6192iqNnFAo=;
	b=h6CCA0zX7ZPtXPCzBtjmOyOtCMQus4IZFB2M56HntHyaPkfEOkqTfGL1nsdO9X+zmGqC
	 3PZIPUy8MF07zTcVtPsRIHPv+gAWd9IY8sa6hmRUkorRkBKQcDNC9a4cj/ZGoGaJjMn6W
	 5nwLeN3QrIurp3uwTLlQQggfobDn8BMtVSvsWep0yNCyBfhYsjhGHFHZGCIb+guIz653B
	 QQP6xcktuegjrwaruVlX759DBhUhpc3KchyHWMa6Z7JC4cmDPXGReiqXvNMfjTqBPiKtQ
	 oNoDKGGnE8WJXbPc29UScH0Txu/GrCGCNxNFHl3xLnfPf39JPYAKZiMqOkWknsq8o4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q9EoH/ak";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E960A5BE3;
	Wed, 18 Nov 2026 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9EoH/ak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B561F00930;
	Wed, 18 Nov 2026 02:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968558;
	bh=QzWAy5ljzbSA7LAk4a53ozwyTWaW9lGp6192iqNnFAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9EoH/akzg6D4vzXOQRbdvJrRe+I7oJ9CBX9AcLYHdBJz9+kObzZGBgZgf1wDkuN7
	 C0ZsYSa/SY/1YrsHWW5iHiJI0VcCREZsVKEe1Jf9pKWxGFqax8dfbjb6hGeKJ3BR1H
	 pATLEkLnLXIYLVi65DmGRJaEF+MJgVL4iDMUngIAabntxEx+MDVZlqQDO+T3grHlMz
	 HfClme0yDcm4fQj+s0F+H/Vxd7ewx41b4GnfTFAxLBNBHsa4pnw4aQgFu1IMmz+lbC
	 FdHh+q/pMe/NH8eOsNyqcYOiCZzahParKq3LbEjvUrIOPCX5ps+ZudAXL5JScOyTuV
	 tQzkBbKazYayQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 18/27] Docs/admin-guide/mm/damon/usage: update for REPORT_MADE probe filter
Date: Tue, 17 Nov 2026 18:22:13 -0800
Message-ID: <20261118022225.100659-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added REPORT_MADE type probe
filter support.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 644250c7bd681..ce4e9e4c13276 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -78,7 +78,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/prep_action
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ filters/nr_filters
-    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path,min,max
+    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path,min,max,filter_report_type
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
@@ -317,6 +317,10 @@ filter <sysfs_filters>`.  When the filter ``type`` is ``hugepage_size``,
 ``min`` and ``max`` files act as files of the same names for :ref:`DAMOS
 filter <sysfs_filters>`.
 
+When the filter ``type`` is ``report_made``, the :ref:`report
+<damon_design_attr_reporting>` type for the filtering should also be specified
+by writing the type name to ``filter_report_type`` file.
+
 .. _sysfs_targets:
 
 contexts/<N>/targets/
-- 
2.47.3
