Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A6274B2F;
	Wed, 10 Sep 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472249; cv=none; b=o7KYJ/VtGSCuaNGMMlsYE/WfDTfMuIkSAPRE8Lwpwp9ZxuL727dS+RVm2AnZarCMElOTdU569YY2fyMOCNVpPdK+sDJ0W2AI+kGRHfCLHg9eQd2rW6nrKcjzILsbqPXCu2h+tNmMqlJKOQ6uaFa11AburWoe4JQhuD65RB2mU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472249; c=relaxed/simple;
	bh=WOOeaeuC9/RH4phIV+H+QiLxF/prahARBSHjeoa181M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRKe8UGdvynwHFnYg67Tm4lCrDvlYDKbWw03oJ5b4Cvjj129fcP5mYrqtq1kSMm7JyodJr53i33KjU5VQXjz/2wZgkoL9CccIcWvFpmkA/iruBkYMXsp02gZoXrVBFxcUrFbxrp1gCBiRcti28+gw+YL5FNFLhJ31Vy9Lv1xI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnistJ0K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnistJ0K"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244580523a0so68087295ad.1;
        Tue, 09 Sep 2025 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472248; x=1758077048; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BATnrPttTGOeKRCCT0K3V4HzIU9KTE8stAVBRczt2LY=;
        b=EnistJ0K6tiuMGdOGl8FLU0WW15qCPZ+NVx7cA8WaQBsmlJpqhmaLnlVvdmoK/T5WT
         FFs6vrfoldsrd+NA7VU6VncLEPY4U+Sj5G6ba6Jm/lNiGKcsIHHwO92Zm5QvoOpuwI6Z
         Ybpyy6HjkwYuud0EYnhL4v5O9pP8lmiTZ/HHEsRMqZdA3Wb+XagBmWOguZkKoWDVlx41
         aN3YBQGUQz56L07/FFz5avdA/0PaDczWKeN88OB84QIIOyBs38Ox+gyAetHQ9zJyWvJi
         AIhQwNi1M+IIHwXiADALEZ7jivnf9QAGVcTpOUTCkaXr8hhbWh+CCR5xqVUTnV+AGLZa
         d3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472248; x=1758077048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BATnrPttTGOeKRCCT0K3V4HzIU9KTE8stAVBRczt2LY=;
        b=RwZ9nsbEH5OmiWiOdfzO1M/xe3OmAzZloHGmF/2L5TrqLmupQH4nZ0w4HbkLUWdOg9
         x/4AoV0sA+mlZ3iJYGp9f01OE88fbfKMd33Hl3US66kc8zU0m7tP+7wOlhjztaIYo4HW
         FaeJcD4iEFMBXs+lNO73EsAUhK734fWAuHVq5ooylfj4z78ZJw+zY+JXAHX6aknZgW86
         D46GkfoSOuKLZTClABySJWiH7Q18Xn221xHgXyztS7Kc8TEkKBlQJFtaUTMJ7DddSl9j
         bWYUxV3Jjh6ggkXZqEtv4G6uIfU8lElrMXQG8vGONMMWL1VM/8oRUza+f4jhC+8YQT9c
         kiDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+4fZ7DHbE2JlwftJmSSS9PA00VcfR4NQcV+FVbLERn5wPq7Krn4WJ3CWq0tIKXblDXf6xXcUPenA=@lists.linux.dev, AJvYcCXrARXmkkhBV22gIXRPw5pr/XK9qXidz6fs24uOBecceMqPmQEGW4IVN65/xWItVJ2b0+0enA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnnAZr/DQJ5pSYWW0xTsUx0wHkHSlHeaWa/F6EzwsCCvNcChgj
	nHzP9j40gtYeJvuPwQQBQtWdxE04yfPPXiZWiMnNBQ6VMLSX3mxKIqrr
X-Gm-Gg: ASbGncthIJJjkphnE/2aPyVw+XUH5ZMdpO5B6g4FyYDINsvGpJ4ZnS1KMdfA3GMCuLr
	8QQr46bi3LSfNQQL7QoJ6oZINLyCc3TSo5ExOl/MygQJrdfxZYU8V35u1ICVovo/sfEgdLDhsHo
	rCB6RRj9Ob+0pznBL5xrTLMs7j8Ok5PiJFJxXBJ1mT89sT+jF6fx602+auwF1GPLLjCtsBKsD0+
	nIXeav0qpaSv3a5ZQyCYoQ3mxgKrxfbSWjk/pMsq9jb0jf+NxPnxsu9AvZT2lBvUhiH56yxL2N2
	1r0DMXuo/UvVfJIIGtwfP1bDEhgGRFYBxexXXaAYgcpyWhkDSMPykoPIktL1iAn38K/IrGWPX+O
	cFQnjuD3KQg5maKk+haueqS4uHUViZsTZMDDQ
X-Google-Smtp-Source: AGHT+IFT6YbUc/m0qKUsx2gIlS1cyHwFE/YTWi5ShK7yx8zu8toS/bxgvdpLpOBm2BAA4mGAvmnSyA==
X-Received: by 2002:a17:902:d501:b0:24e:3cf2:2457 with SMTP id d9443c01a7336-2516e69aee6mr211563725ad.24.1757472247632;
        Tue, 09 Sep 2025 19:44:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662ef781sm3491871b3a.90.2025.09.09.19.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AD39841BEA9E; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
	Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
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
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
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
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ranganath V N <vnranganath.20@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 08/13] Documentation: gpu: Use internal link to kunit
Date: Wed, 10 Sep 2025 09:43:23 +0700
Message-ID: <20250910024328.17911-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=bagasdotme@gmail.com; h=from:subject; bh=WOOeaeuC9/RH4phIV+H+QiLxF/prahARBSHjeoa181M=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnijZrvnhN9eJ1+LvAp2zslcUft9O2uC6e1HKcd4J/ rFLDLiudJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiyg8Y/lmtiNJu8EtVbugK fub0kTH31Gy3pLdrgoTZz7qUXricksHI8GebzZaeM9lhFZ8KFVTdJ9stibqczP1vypfAmIZda2d 1MwIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal linking to kunit documentation.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/gpu/todo.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index be8637da3fe950..efe9393f260ae2 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -655,9 +655,9 @@ Better Testing
 Add unit tests using the Kernel Unit Testing (KUnit) framework
 --------------------------------------------------------------
 
-The `KUnit <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
-provides a common framework for unit tests within the Linux kernel. Having a
-test suite would allow to identify regressions earlier.
+The :doc:`KUnit </dev-tools/kunit/index>` provides a common framework for unit
+tests within the Linux kernel. Having a test suite would allow to identify
+regressions earlier.
 
 A good candidate for the first unit tests are the format-conversion helpers in
 ``drm_format_helper.c``.
-- 
An old man doll... just what I always wanted! - Clara

