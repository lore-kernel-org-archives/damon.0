Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93D29E0F7;
	Fri, 29 Aug 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454139; cv=none; b=PeXxzCGHqBdheaNZZYNdAfD2X6l8euMfsakQK+5iPp0kODttl/9cWuY872QslxJqA7rPwIFSSBudYMb5k+TOjTX3uCTuQEKWFmVCkumx1OyasIozNKGmt5GUuQJkhkOU6v5XbM74Jk61CAxf9i1pbBqwIHSTBPDxi2H3eUo3ETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454139; c=relaxed/simple;
	bh=OYt2QegR/+u0q3CRKm7Zg38q7SY9D/3L6tdzv43Jflg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz0UaEakXxpaRjQRuYTtmrhK+NG88xr00dah/1gq1KjBuslgKDPaKND4qF9KDPx5H//qebgsjIGyKA53i7yD8uRZY55ZhXLL/qx+7fhnGcviKhW1alrkV2X1ya9VPLC6hfQ3pdtlpOUZ84nRrv6wNwYJJjgV5hXV/6kimMG+PoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsbHSFk3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsbHSFk3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244580523a0so18917625ad.1;
        Fri, 29 Aug 2025 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454137; x=1757058937; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0koFSnJrv2UowuMhMeqtiJIslvN7BbZv6mHXQ/mKo7A=;
        b=bsbHSFk3dGK8g7XqNYyGo5ZrCoH3Vf2MjMQWPZDPR4IqS+sqBbsrHXdoCLJNRuFxlt
         1IRCkFNTaWnvVDc170ZvkSfCgOsMQi1BOVUU0UTA1PJ3py+y95stk2jN0UlE8fkxHeah
         WBQv8Qp3mwQRuPlwcZrqnBzoJ70/PFZpNzfmtSSvLFuOl9ZahtAdCydBH3EsQhdtxbWv
         9WWaaBxpnjpJwSVaJYZMsR9UGaBBmMfnBo5o/dFtdYOsd8f1MObR6Xll1KSe6zBzK4U3
         GlfgcYaF63mvn6ffhmdTzvyaWl7usDvjcjM0PwVzT1Q0AfA/2FT5H9Ipp2JnbprR/nOV
         cuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454137; x=1757058937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0koFSnJrv2UowuMhMeqtiJIslvN7BbZv6mHXQ/mKo7A=;
        b=lCmLE/Q71oqfm34+QruaBxgAJcjJy1qJ0Ll5Aynv/7BnoXfIhqs8iV52eD4XSHZdXq
         jblk5A7VbZPVC/JXynA8eUKkIk1owu13BCLWwbCH29O+Uv6548GOuOsevl/kjtNS/0fN
         UgrccYObVvljxrThoVHaAQkCfc0ExcBJ4GByRYGVjNUX60xu4iI8sJ+S/zfzxRU2mBRR
         nv17i6jK+mzXyjxSMYuz6UmsBP1eBUSkxftM6+qMZhrOUlPKXOk1BJcKqDsX5XRCpd/0
         dVYwbaPkNE6/To7ZzVCXGMlLSsPqMdeWkLXjiIGVZ/R31/jILWFcx5icTQQ9AT/WIMZE
         aeVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9p+VNZb8soBQbfOdwh8Zi+N+pRHcO/34hnW1XQMoQ2UXNlGA3dICb+6b0hHMhCBo+UCykfQ==@lists.linux.dev, AJvYcCVKFShOqBvbd6MGqfi/QeCVrjz8FFDvTqKFSkhdxilapk1jZ7pIAR8ZeduTaX6Qyz1v8nr3Wau1qsE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxOAW9wuTUpcmy2ONxZ266HO4KmFSVmkWAbSmmNsm5BwfJhSPyG
	BRXjqp99DkKItJD3dy9cgqs+VtstqwlFvrHF1S3B2nC5sqkBRGRm2f0U
X-Gm-Gg: ASbGnctOIY/BRcb9Bzb9hL5is/CMZMVeK/BRWUAAfospwWoU19vfwvqn7XZSdhKWmRm
	MJb9AcV8abnNHKJe60ZBzdhOw6q+gDVV2TKh6DKPFPs4iwZVTcbNMjp2yxRvbozt12FEms3t7+z
	x4viJd0CnOyYBHF7Zive22z5Ro+8q9Dahy0Bs213U4o8Qa8LUmBJr8NhObhGyW+lCA8r/AoTW2w
	ReKz6grPwH65HZw7ouM8bihg6RMOgz5dFv6yTQoVkwodDzyQ7mLlpcVYa9LKUkeXXgYkaKwc3ag
	AfVj+aRiEEe0u3W9cxLeRhaJkhkC8zLfFgP16yB8UThtiMZinwGQ6gpWvIZ3bfEHTGwfyLXXpIy
	d6hnO232L/gM/fNsKSlmWfQk3oQ==
X-Google-Smtp-Source: AGHT+IGNjBdTFArxVwVJhrEyw48u+wDRa+YP0G1KaeCtmArj8lT7+bi74vyrPcJB8r8IUDLpPVmmVA==
X-Received: by 2002:a17:902:e888:b0:240:a54e:21a0 with SMTP id d9443c01a7336-2462ee13154mr358734785ad.19.1756454137188;
        Fri, 29 Aug 2025 00:55:37 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da26b9sm16688215ad.93.2025.08.29.00.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2F80944808DE; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DAMON <damon@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux KASAN <kasan-dev@googlegroups.com>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	Linux fsverity <fsverity@lists.linux.dev>,
	Linux MTD <linux-mtd@lists.infradead.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Build System <linux-lbuild@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Sound <linux-sound@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	tytso@mit.edu,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 03/14] Documentation: perf-security: Convert security credentials bibliography link
Date: Fri, 29 Aug 2025 14:55:13 +0700
Message-ID: <20250829075524.45635-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=bagasdotme@gmail.com; h=from:subject; bh=OYt2QegR/+u0q3CRKm7Zg38q7SY9D/3L6tdzv43Jflg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY17WLH+uxHuD5TvzhcJo65MVRz8evf+ht/Kg8H3eu d3xR8redZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BeAmZzL8r1qVsXFN0aQnhlcd HbX/7Z5y0OBc87cVSY827u/OC7GTfMTI8J1f/vkt1YY1nGfMLy+IOlnmXaYQu3XLZy7bCT/2T+u /xQUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal cross-reference for bibliography link to security
credentials docs.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/perf-security.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
index 34aa334320cad3..ec308e00771427 100644
--- a/Documentation/admin-guide/perf-security.rst
+++ b/Documentation/admin-guide/perf-security.rst
@@ -311,7 +311,7 @@ Bibliography
 .. [2] `<http://man7.org/linux/man-pages/man2/perf_event_open.2.html>`_
 .. [3] `<http://web.eece.maine.edu/~vweaver/projects/perf_events/>`_
 .. [4] `<https://perf.wiki.kernel.org/index.php/Main_Page>`_
-.. [5] `<https://www.kernel.org/doc/html/latest/security/credentials.html>`_
+.. [5] Documentation/security/credentials.rst
 .. [6] `<http://man7.org/linux/man-pages/man7/capabilities.7.html>`_
 .. [7] `<http://man7.org/linux/man-pages/man2/ptrace.2.html>`_
 .. [8] `<https://en.wikipedia.org/wiki/Hardware_performance_counter>`_
-- 
An old man doll... just what I always wanted! - Clara

