Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774549;
	b=FhwEZOZctwFn9mv6m9nxiSWXfdgBBNQlYGeJXAvzHzoRWVVPU6qBitAGmBgZKAOFFsvH
	 x76Adzwr7eirudzRBInmNhb1xu6GIUSIvts898pbZ5/tR0bbNXUDHjn0fjEpCzkIknscy
	 yFMXALQamZEg4DNTdTuAxIMbWP8rmKJJPiQqjmeRNlNK6jzUgDZj2dqTKEeVNfNj5y1mK
	 PqFUPryQwGbjbM7MoJ4sHW4q0R6obCtl+q1NuEoZJSa1CiLi60Yf/ZK9vpTjgiZ7Pjc97
	 LkQLDgDn5jNt+KhWSApYmGYU6ubXObI5LchZ8tRl2mQod4r+fCGzfUWR+zpTi5OnM0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QzWAy5ljzbSA7LAk4a53ozwyTWaW9lGp6192iqNnFAo=;
	b=v4ERYxL3wLe9rHOeyqS+OwdV9kQd+/8mgnD0HoXYfYLcAO1pMenmhS3jLs5dSlx5BgKa
	 RD60A6Nk9A2V3Cdq0mfNTKWZsHrkWJ3Nv3V0uiL5KhMtIFVrUgC7HmuchQmpzpEjDO17B
	 jfXZoXmc0PeM7rVoBc5qGn/Z4KHfJSDaaunMTkmNDHh0L3EgFbKdCIcw53zRI7HsNKnwi
	 4orGCqeGeCPnZZVYyKaL8v8lSn81bsrOPi4XvpOvRlJNy4dnQyB/qjhNPyowjf5mxPSjW
	 4WBwpl4uKOzgsjVwfhWuVa4G/UMd8JobrXfj5GwVKAI49cXz1h29O0jH9wnrkdzYo6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9pJQ0Iv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6C60A5BD5;
	Sun, 15 Nov 2026 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9pJQ0Iv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDB91F000C9;
	Sun, 15 Nov 2026 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774548;
	bh=QzWAy5ljzbSA7LAk4a53ozwyTWaW9lGp6192iqNnFAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f9pJQ0IvrveC0MsfxjYm5mhQu5EMLJDV66AQgcVUtRsXYvbMkDTnQQBhcSNHNv2OF
	 TFZk3Sh4TxIWR2ztM3w/n3YMR+yaOYwJ1HWoH8wHSBmSDYeZ1cz8mEXY1sxVg9omkw
	 zQy3gm+aDyiAHWGRZ0hRkTpHVbC34qSQIyCG3MpHtjcK83H6F1aqLTmW1qtSDnKfjR
	 S8w/19HMAbsiyTjJHUaCHwZ1ddiBovWR0hxE92nFtQPUYwqgCk35MdugvWRUOZjBrd
	 8o/rBzAEh8BoEfgJg1YAKjg0pxZmlmGScZ2sHS4xmExqLY7zsSCXjL3PLGyca/QyVw
	 imiGYtpDkMvgQ==
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
Subject: [RFC PATCH 18/27] Docs/admin-guide/mm/damon/usage: update for REPORT_MADE probe filter
Date: Sun, 15 Nov 2026 12:28:36 -0800
Message-ID: <20261115202849.99134-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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
