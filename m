Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC63B9D97
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871497; cv=none; b=YkBR+MbkLKBxCW85JnIZTCUTBnw1uo69aLJfSZToACPOggrziRvZymKlbpBRhRlOZn5/UuGcfBWhIFvyMgPgWjHs8o6rwzG6sXVN3XaCQohXgMyZWbLjNDLp35dBZX8F5RBbKHEX4yiazpEQ1uRAJ4GbSLYANTs1sjOwGCamY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871497; c=relaxed/simple;
	bh=ta4KGzvy3+Q0Ym3V/maRaZ1/VI/KlL2UlxoFdTcXU1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lh15hUO/ps8AwOhnA1EcFdA9qUNpXiMe/zlid34I0mEIQp8ABz9ipvIpT2d8L7+miNzl4QhXsCieNdXm/b04zXUW3xT08yWBUjTaH8p0/vMghfA0QWPTpd9yUKLJd8UlAeeMsIEvc6b64DAdrPmahu63/HIshoiSWNy8NSDScqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iywQ/qQl; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iywQ/qQl"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8748f34b1f2so1893782b3a.0
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 19:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789871487; x=1790476287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucMEt/HYfCdI1ngc+n5yPNtAEmxJEE4zo8QA8w8ZEKw=;
        b=iywQ/qQl7V5VUgeBK36fU7bHqYxhAP7FDd9j8BfRQ+5ayjnvLEcwJJ61u5UR3dOq5n
         +u9FiIcgRHIKvCGkzRQm+kISXEdAzpGcghojJc4HjoaAxWN/ppJFKqHCmAQXKTYsc1xQ
         tBZRht/pveXG+7vfLwX1vTnIlkik6QLeak1czludl/MrIGSWQLOs9eK5EsWBqBUPWi8M
         i9N0+8tzWxsgmacHreVxCUPG8EGtTCE6cuPoDXPb7GffVep8pOs/q77gc63/bvguM8Vb
         UgQQKkDBXdJ1cPWZ/FYcfurliekbbx4pPIfJLo/n5ui7u4yp7ANuXSd2WsIDkh1gHB/t
         xcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789871487; x=1790476287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ucMEt/HYfCdI1ngc+n5yPNtAEmxJEE4zo8QA8w8ZEKw=;
        b=jHETAXF4G2SEcEeqBqi/35LtlpYklK+trXf4GBEPyTpuV9tpeu4KgYFgMlGxghUsT6
         w4JVlQgbrUNMynC/t1xyvN9kJ46BC5ZADXB8Ibuvgvznf9x7ZrN0BFjrx4QnO/m/W8Sx
         tu+E+MSxj2anDBMlHcPLCvQw7+CoIcl1KCZJZDqfzSRgu4oX3KQU/VtSku85SPQYQhKZ
         rmork/O1z/0lFwZ4fGmpz3LN9zxZe97nfTr0kWCMYITLYNr1Gk3Jzt+KIeAsKEvyNiqc
         t4YDYblKq8ACIJH8BiXJ41VHddrfDihdR8o3S1m2lPx4oGhR21GYmMv6cjG1FOljtur4
         s2lQ==
X-Gm-Message-State: AFuF++ked1VDfLLCiWrEUdaWfAUjjm5RqXF1jYAGSwUi8PMlQoPZPgiI
	PQR7zOtsyppbidlt97Jg6zJzGLMgzNJXAU/GMjcma0Jqb2cHPI/kfUc=
X-Gm-Gg: AYBFou3PhOxW7VVhB4uPuipxi8+tsbL9rWSrk1tv2sMqvgw2z1aYKyKzR9qrYqq4esf
	uTAD4eXj4FHGHC4/8a76BBVtlF0pbPAU0wYNgb3XtFrfjkd0CVgUEIocIYyerdTEju2lOgZhAcf
	/U5v9UhNWnZYzpAvAuGq6Sp9MyOc0A3U0rVgGSEWtdP/Ht8QE2zlDLaekmHTxZ9u3Vgl/2KtR2m
	GRnGUOf7VuRCahR7R1qgERraf/D8L+EjD9W5jpQbu780MrMIFyCFfLtnMJ8MKJoWlS5exKswtFz
	v1C6NQ20HwblkugE93cD4aNOVvfKLNcLug/+VnJBUa2o4plbpMW3QR8haOSYl6gv/Ex3E0S793i
	hvlqW+B08etS38ly+f9JzKNtfAPAAPulu+M2V/lUko3fCDLHo5yZTRHmzvg7S2V9524dyg6a/WC
	8SWy8L4x92R9IPtZOQMrDlkFYuidGgosDySTnsaiR2gcLIpl0lXgDVDcONzOxxX3bl+XQsg2u4h
	cs843dm2OSNZ8dGdb5Jx4Kdotaiz1rJ0A1hxg==
X-Received: by 2002:a05:6a20:2586:b0:3dd:85a8:4c66 with SMTP id adf61e73a8af0-3dd8c5db1e1mr10707714637.45.1789871487313;
        Sat, 19 Sep 2026 19:31:27 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:36d8:54a:e0bc:3e5e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aee03efsm1481341a12.24.2026.09.19.19.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 19:31:26 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 3/3] Docs/admin-guide/mm/damon/usage: document the temporal tuner's quota limit
Date: Sun, 20 Sep 2026 11:31:11 +0900
Message-ID: <20260920023111.2466265-4-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temporal goal tuner converts the size quota into basis points in an
unsigned long, so a quotas/bytes above ULONG_MAX / 10000 does not fit,
and is handled as if no size quota were set.  On 32-bit that is 429496
bytes, well below the "echo $((1024*1024*1024)) > quotas/bytes" this
document instructs.  addr_unit does not raise the limit, though a larger
unit does make it harder to reach.

Note both in the goal_tuner description.

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index ba47255448564..ea7443b307826 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -455,6 +455,13 @@ the background design of the feature and the name of the selectable algorithms.
 Refer to :ref:`goals directory <sysfs_schemes_quota_goals>` for the goals
 setup.
 
+The ``temporal`` algorithm converts the size quota into basis points, so it
+cannot represent a ``bytes`` value larger than 429496 on 32-bit kernels, or
+1844674407370955 on 64-bit ones.  Larger values are handled as if no size
+quota were set.  :ref:`addr_unit <damon_design_addr_unit>` does not raise the
+limit, but it does make the limit harder to reach: with a larger unit, the
+same amount of memory is written to ``bytes`` as a smaller number.
+
 You can set the action-failed memory quota charging ratio by writing the
 numerator and the denominator for the ratio to ``fail_charge_num`` and
 ``fail_charge_denom`` files, respectively.  Reading those files will return the
-- 
2.53.0

