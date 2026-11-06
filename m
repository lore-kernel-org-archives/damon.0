Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930768;
	b=X7hzTv1WwbzSxbOLQ6+fmVD41JQvnDT+RvzwpLESyw67btIRgN3IrFiggKuyxYhr6z3h
	 WPG5uCK301ziAzYfaxHdZTMdzCEuviFQZ8BLgre21hXPlEzNDjaf0CxcCiOscBmy9Kw9q
	 fTpJ8Dpqei/wF46uSpQLMs6GT20NqmPEMJHijkKXMnOJydla9MeLU7Yg+btVPw+fktGVE
	 eJeWWrZuEloWcAFFiDzfBBkXN6ErTm4NC31B+pZAJiz4baNxq3G071FQ6U51OyLRFTTZq
	 maApN9OOWWHvECh9Xhr43Pv2mMqvaKz5PHctA8NX/g7Q59w0mra0sWGZlyE995rZmSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6jgnNWSf/GS9C16/6/oW04FCJlMaqBDrU/5PeIB0ivY=;
	b=MWZEcMglbJI9zm6Vjzo5q4zD6vbqSU2ikizw+69bHmSZQx8sz5bN2t+aZksSqzXEcy1C
	 85ctA+oJ6nv69XYP0F4S0GdI4WKHjUmMmj48s4EUV6JecokENQNDA7serkkCCvR/uzwvM
	 MD+Gba/mMVSn0CHH/ya1UPzwXUWwSkqDruQOziHR87ks7Zz3YmtOy9Ngcwf0B4kmi2Vwf
	 ubijBSqj/ceET8Yw+DcmTcONFPPv5ln1FToD8IMdHRo0wvIbZO3oFfwn3DXoVkycaHLIu
	 xYj4mKufN1fvr3WBm4yw2SwvusvBOk3kGI52Dam3iNYT1iNQHC9TFmb2wFPoaJ6vtQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+o8Zs4u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE79606A339;
	Fri,  6 Nov 2026 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+o8Zs4u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0EC1F008A4;
	Fri,  6 Nov 2026 02:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930768;
	bh=6jgnNWSf/GS9C16/6/oW04FCJlMaqBDrU/5PeIB0ivY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b+o8Zs4uMMohaqHf7oACOGb0O8r8zWS4hxH0SNbME9OEiZy7vlKSf0eARVaV3hPGv
	 h5N9pho+5C5Fd9FRKQhLjil2jCUc+o4JKhd5YqrHUF6IKs4DTFhTaVJJnOcfjpZ3VK
	 5IivQl+uVEnqNgNhqCLNNuu8xDtME6UkHej5oIxy7IooLMEkT+ul1GSVulir4zl5Xs
	 0VNzEM1L98djvD3n2WVDkyunVZ1hIvNnpye9ao0H9vgvXMpxOWu1Wc0K5oz4O8Tq+A
	 SKOD7w8MhNYtSu3InvWw1ZK+bjUsdVNPh+WTa96Ehfosk1VdH4byhqzk54mXV3ngVk
	 KIIt2U0cMV5Qw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH 3/4] Docs/mm/damon/design: update for age_ms damos core filter type
Date: Thu,  5 Nov 2026 18:05:57 -0800
Message-ID: <20261106020559.98352-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106020559.98352-1-sj@kernel.org>
References: <20261106020559.98352-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added age_ms DAMOS core
filter type.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0689fd48446dc..8440c4954090e 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -838,6 +838,9 @@ Below ``type`` of filters are currently supported.
     - probe_hits_wsum
         - Matches to monitoring regions having a given range of :ref:`probe
           hits weighted sum <damon_design_attrs_only_monitoring>` value.
+    - age_ms
+        - Matces to monitoring regions having a given range of :ref:`age
+          <damon_design_age_tracking>` value in milliseconds.
 - Operations layer handled, supported by only ``paddr`` operations set.
     - anon
         - Applied to pages that contain data that are not stored in files.
-- 
2.47.3
