Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294827;
	b=q7HUZJTyyFXlNLTok7StNOGi4R3yHs93oFFfDI8OBR58cuYV1bZkNSq6ZU6IxFHZJNTF
	 CmgEJ/QfC8Z5SbSPZ0A6TP1sLNCDByzk+40jcAzWkOTDKCfyaAfs63IUcnPBKwoB0ueai
	 P1+Q60oCacli07tRLN4ft3GdXbP+4RDygsmvnCtS45WmM6pMOEG11hm8tMhVRbCn2Z6R4
	 ygsdyZ7gI3IMvUcqlY8KmC3R5a0PdvVkeSnCZUBb0CgpI7gHqzvR7p1IwyNROsdlbzc1h
	 tVdZOvftl8TfHdjBpU9LFKwffBx41H4xq/JxaQfD3v7YBVL+uMIh73cD0DnwWdiHPrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294827;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QzWAy5ljzbSA7LAk4a53ozwyTWaW9lGp6192iqNnFAo=;
	b=W5d3OEuzNBAkj0uZq5xavxw3JHDRP9fCUtrBFUI/fQ05zKHkTsWS4wHFfA5x9Fb6QboT
	 HJrasJv4RX2rD58RSj1UcrwUZYJEpHWRmi3lYGqzmocf7u9V+j6QKgQ2n/SG6aJC6w/PM
	 kAQB4cfkOdYegtcsC/j51Nu4Fh+qjvQkD16TP7BohWMwZlqgsSZETHaWPvreFB5WCMC1m
	 uV9z2TEPSfkg72V2cc99H2GmatgoF0oPsUcenzIvGPNcXuyZsRo4/kYofXGkQ1eDB+l0I
	 vKKNJQjr8EsoOIBDXxUqGusyajrXFDvGTpuOL+gnxNoAPJLZRKHOD0sT1bEAp1JrqDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eg4b87Us;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B458606A32C;
	Sat, 21 Nov 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eg4b87Us
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB191F000C4;
	Sat, 21 Nov 2026 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294827;
	bh=QzWAy5ljzbSA7LAk4a53ozwyTWaW9lGp6192iqNnFAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eg4b87UsfARa+Kj6OZKECF4s+KnvrR2O8U3LN9Qywf4lsek7PwUBTQCkoCAlxl4JJ
	 31CV6Z47vv1rRl8V5tA3p8H3CCC8F7F/8wHPwyzPDc6eEsDcN4D3xxU6dWHn9sGSl1
	 hcOb/sF8NzWVkBqWldybddYaxuVkNsuqIdHwunLJh/sOVovtkM4avYeA1q5K/gLuUj
	 NruMQWhS6We5fDKGPiYgAmO5Q8TqhPhVEPra8Xfhr01+TIoeUnp1IxEYS/2LuS4Q+s
	 YB7z1AlJ2y2MzS6lClPQSwPXLVcPNv7fQgZCfNpvePu1bQEwnVAD4gjreYX0+VG9gI
	 leuIyR7QJlXjg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 18/27] Docs/admin-guide/mm/damon/usage: update for REPORT_MADE probe filter
Date: Sat, 21 Nov 2026 13:00:02 -0800
Message-ID: <20261121210013.130397-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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
