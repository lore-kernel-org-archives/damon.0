Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D326B0BE;
	Fri, 29 Aug 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454578; cv=none; b=cSUOWSisO+75mcL3KOHTHC0LkIZ+18sb33i1ORpP0pB4WBbJ74V4h3eqHJ3XowUUKWsobvn5Ge8M2xMXFU0xcG4Z1VFAZtjEXG9QvM5iGC+FovRsmjR5Z+RBAKI63mypCdDtY9Et9Qie3Y04FZpmIkWVDwlWbFk9A9PRfNqaSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454578; c=relaxed/simple;
	bh=lGvjj6RPPbr58GqrWqgYvJfKnQd0kE/Khje7rmfw55Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfclUnR8Vi2Ycci4B1+IOAB+iWf2TsUFCHV8fdjacbJAUDXA9nSTyaL4Yt5+VreiW5rqy3yjEM1q/1fIpoJHk7RiQPp9hBuejuyD5/bx5z0sJogtjFZSlqJRrIGpPGNfqjQUzng9lT/UVGx+keeaYsDIvcvv1OqsHwLvW6Mpw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLUlVQw9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLUlVQw9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2489acda3bbso14190215ad.1;
        Fri, 29 Aug 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454576; x=1757059376; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUuceR9E3vzJz5a/JHCoOJAb1uIOOWcnyWbxLYGhp7M=;
        b=CLUlVQw9+ft+Z2/Y6nLsZTTvSgEgLWAcd1heKhz51ubZH7uq9ec8nj/I2boYDlUmL5
         UsX1n0+5goLo8ubzDkhPqEfcvvJZbAA1blbDkNGNDYOmV2hOppBBBh0qUIhCMJgfyYnc
         0bpXK/Om3o/ILpmCX8oI+Y6YNFTzhKHvwHBxwr4v3CVWICza9CPdPGsE1hmCkDIiXSX5
         bto+MFV1XuqSZfzfXVj9C3rkofm8ZnRLjZQiPe85hriACEZcozPP2ngDdklZAERZwxGZ
         cAjCGpGVRGbY0r77zQLG0343XTZKNrzhN6Gd8fZ+Z//fjJHitaPMx0Ad8yFf17V1qLxg
         XRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454576; x=1757059376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUuceR9E3vzJz5a/JHCoOJAb1uIOOWcnyWbxLYGhp7M=;
        b=WtOcXy4e7XIUjeoA6Do/+zquktX32l/RyOYPzHCXfAnmrfxBxO3AQ1wY2Areblln/x
         hkZya0+GfK6xCLtCC4pv1oNNZ7+4W0z889Ve18shSnY1QQczNwWpR3bJfPfZjlSxxNGm
         0OpqKhl/if8e2L8EHEvZGEdp8jO/Cz1gIDvGpsbjov6BdH4QtMn/6cZFuCXegZGu1fP7
         w5Zf+m/7J66/dkcg2UQkClYoC8BMEk4llCkZZl/LfD4huhsG/z4iqS0x1UmElmA2s4ir
         9PtgAhffITO/eAmRbwzAgq722UH4Q2rpRXJ3EYBvjP/Iun2iqN55Oj1cW2mMPE4yIc/3
         yFmg==
X-Forwarded-Encrypted: i=1; AJvYcCVLzAh764SOwIHHGPPn/4scud225San8zFQufRwnGVxUeZT5SM1ivFLT+dPmG4xB9EKpRDCGkjJdFQ=@lists.linux.dev, AJvYcCWLHFsO+bVZO8UVVctGghMoL5BcyhRn7vvkpIiZRMk2WgYzueoDc74MGgKzDHprjKZ3Lu+JgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyvY0FZJ/FeHn5XPUWwZimj+7Ga6rX58e9svmaWFbOxzbYkHwu
	Sb4D/v1NtOH17eyRxgdBomcJEAZaENnrpdjZBG1g5IQ4CDfhbYQ03TX3
X-Gm-Gg: ASbGnctf4DuRZF8xWt5lC9GSdtD2mr89cmrsXrIUzsfZbsbxZpGpxQWPAtMh4IYeicm
	M+a2YRudmx+y97+1jtMTvkJEITq7W8EqlZnptbyX2HYEi5qfEtCVbFsmM03G6rIpBlOxBlEsB2H
	E3shtQexi26LEqHOpx5OeFQ3LK4qYd0DvSIxrysL95JiHqAGE/EZFzUplOdCbUavL7rGp2g0T5C
	MKjqXn6m9sMyaaiLFfOcFEXwPkZHOD1FyJdDiF5D+Fw2/AiFnP+F8PMVZ6U6I3ln4JF0xvRF6/V
	Sr8FI+xeEwYdJmyhT8pLXSaIXpwTuyXS3N4FdmOiuP1jNXMJzfY2RXYi1GGcS+1GnuoYYlNExmG
	PjISoT2ALJ3jYou6gLFNo8tYhGi5v24ZxZdrd
X-Google-Smtp-Source: AGHT+IFt0CgZnKjzhJ5g4aj0Cm28ZWwwe3q9IBbh2aQ/4X9BQsH63Txhma9tsRWuYD6j70bLTYHjgg==
X-Received: by 2002:a17:902:e890:b0:246:bcf4:c82d with SMTP id d9443c01a7336-246bcf4cc37mr269048275ad.52.1756454575739;
        Fri, 29 Aug 2025 01:02:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067de9f1sm16493345ad.151.2025.08.29.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:02:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B95C34480990; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
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
Subject: [PATCH 08/14] Documentation: gpu: Use internal link to kunit
Date: Fri, 29 Aug 2025 14:55:18 +0700
Message-ID: <20250829075524.45635-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=bagasdotme@gmail.com; h=from:subject; bh=lGvjj6RPPbr58GqrWqgYvJfKnQd0kE/Khje7rmfw55Q=; b=kA0DAAoW9rmJSVVRTqMByyZiAGixXOmjSTNEt/JFR6AhPDWfGCcGj/Np82/Az7wMJic3oIar2 Ih1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmixXOkACgkQ9rmJSVVRTqNRJAD+IU+J KWDSPb94prUVj+FntqxPO7boU221XL2jEkITc6cBAKhpWT1CuLYVAMm4rv4hGzdOOa9sljkO4cB hdLolzx8O
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal linking to kunit documentation.

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

