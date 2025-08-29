Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D032D0C67;
	Fri, 29 Aug 2025 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454145; cv=none; b=U2CoysuRItQl7Lql3tf9P7lj18rB02poP6LG1d/Y8RM57rMBmXpi91pk8e7Nt2+/YB6NXBqaJ+SCdIGVuY/PvV9sXaPWgWK7mEUYm4x7SiXBm9P1fqTOk7z/ikF7nHqY0DbDdNtj8AXwVvrEVLfcu0VFyq5IZLHTj+OfeY+nVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454145; c=relaxed/simple;
	bh=7QXrNRuCbHeHgCYdGUN3dSXlo+bJ6ZwXyeTt5Kf+8Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uG8OmFFJPDmzJDg/qLK2p6JtBZiMX8gnZ6qLFaEYeSoAQH9kd/6oML/Hb1VJ1cqa7QIhvUs7QwBoj/HpNeLZr2591/nvbW4mRkM2pGsj23bYwTDEXl04wi6Y/DvMYtITaZnHQm/cCqnN6WIvwnvuFQlkFAb6ImSo7PIkQxgRJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVofYoDi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVofYoDi"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7720f23123dso1815638b3a.2;
        Fri, 29 Aug 2025 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454142; x=1757058942; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exY9byyl4etH+4IQEKnm6qXO5lYPceGxvCuurSN7fh0=;
        b=jVofYoDis3tIjVFm4DkgLrJ3RJn43OCiyO9pHroFLEyURmLpJwCcD4XNJ+B9LX6sCx
         Hd46rYLFxlU2k9t7rmcSndrIi2WeIeY/2zMXc6rtZPJkM1hCBRVcBH/NxAYSsVIORgnx
         5D10/RpyaXaXLNQU5OK39al/2XFTEwJJ9dV3ihrPd0GB2ywv6DF1n419Obb85BvVOQs1
         AoPxHv1lDTk9tgKMuNvsqK+BWlnVD0cbM66IlNHj9AbZLWsEjaJY4lUei6DuNz/NZDd9
         BcZVyGgRibkmOgwX/aUbWx+1LqgCT2OTkDCLPDdDoh7yIukalBtrhtws5EnVyoq7uYLo
         3/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454142; x=1757058942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exY9byyl4etH+4IQEKnm6qXO5lYPceGxvCuurSN7fh0=;
        b=w3/F3tFqgklYV6UlmRZyp6C1gPkx6Ak3iN2cICuxXQ50jWQREonPSo4CEg+FgcQCaV
         gz6qFnGoA2mlQpmKi5JpbwVZhG3rU+vqEEUCmmNlL3L3QoJd8xOLIvnEzFvOntPF9eOo
         caSjMOxzOqNBYNX4vKG+G+kaSKx1L2VtktkROaJC6P3p+GD+hTclOWw+KVoyrhnCjmnC
         FDNziDg2UDZUqlPJeJQ04STC8mcCAZC19rSuhc5dCQN+FmKLWooEPQmMF0dgPTwde9RM
         bGCBgcQd1dhqPH8Synuh2M6geamfCm35SB3zYVWI0k3gpIDSYYrai1sUsplk8NnYMwye
         OWRA==
X-Forwarded-Encrypted: i=1; AJvYcCUmppqU9lElCsllRXxEilK0ii2Mrv5DuwGPufxN5JNHhuAcSCBIQPWnoqpI7WsXMHOIHDT5XG6KKnQ=@lists.linux.dev, AJvYcCWNf35ywzE4CPjOKfvuUzGB2oyXbhplyCSgCUSDkOtdpuXxJRT5ItY5oPfQUvxXtwwVxdIXpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyC7L1K2kt9HIlOBBuoEWws5Ag0JQNC8XjMDE0Gyb3qpENFNIDw
	Pb+u7G8iNdLjlqb6B57PWZY8gDXQKe4WzUhuKjeUsmt78+ZF3RQNVQ4z
X-Gm-Gg: ASbGncvqHQVSHvHfp8x+PmYZFruTOScD8PnK0uM1P0WZiZsZVypF2+9FBzwxCEUkElA
	k8ZGC0FZVN9j0fFLwMFUgc7x31b33l9PEdohsdK/u00TFwEsZcKJGwI6PW/cRWkolCyb7ofxRKh
	JzAbLgq2ulSNU/ktazF7lJcITKSdn1wVq1UX3QO1B9/Cy0Zr/tRztKu4U6QgwKCI+9ewyiCKfHZ
	8SndWu1urcQBUDl4Cp18B1poK0qRBMN+bfvqDU/7cKwoNFaQC3+oPAEWok6MZQG66gdanIesZA6
	XsX3UgT6MSrM1P+Up8pcIonRl5SX/lC003bLKelg7yK+gedOUzScu16ubJtRbMLYPA633nJKF8W
	dvNY7mKAWbehovcfBTKfxOfgIM/PUt3MaTfxbhB/oEnQqVpc=
X-Google-Smtp-Source: AGHT+IGl2H1cpKBrzVIc01ALD2l+GqNGGEJdm0M1vP0Ajl0ap9rVA4eE5ntn2ncpRPD9DtXSzK3gDA==
X-Received: by 2002:a05:6a20:1585:b0:232:7c7b:1c7b with SMTP id adf61e73a8af0-24340c429e2mr42540329637.14.1756454142509;
        Fri, 29 Aug 2025 00:55:42 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2aaa70sm1550930b3a.24.2025.08.29.00.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7A9CF44808EB; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
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
Subject: [PATCH 05/14] Documentation: blk-mq: Convert block layer docs external links
Date: Fri, 29 Aug 2025 14:55:15 +0700
Message-ID: <20250829075524.45635-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751; i=bagasdotme@gmail.com; h=from:subject; bh=7QXrNRuCbHeHgCYdGUN3dSXlo+bJ6ZwXyeTt5Kf+8Ys=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY17q3TFftH6q+kyOiIzsCLYVR/ZOd/GUnnS+Yu6/k 6t6/fl6OkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARpWqGfwYJyctD8hT/NwY/ sO81mNZXoe/tpx8864flkqYm66Aruxn+V81fprfBrut+sv/0I1K75vi+e3t4WtGyeRzBVy1DeSv K+QE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert external links to block layer docs to use internal linking.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/block/blk-mq.rst | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
index fc06761b6ea906..4d511feda39cfd 100644
--- a/Documentation/block/blk-mq.rst
+++ b/Documentation/block/blk-mq.rst
@@ -87,17 +87,16 @@ IO Schedulers
 There are several schedulers implemented by the block layer, each one following
 a heuristic to improve the IO performance. They are "pluggable" (as in plug
 and play), in the sense of they can be selected at run time using sysfs. You
-can read more about Linux's IO schedulers `here
-<https://www.kernel.org/doc/html/latest/block/index.html>`_. The scheduling
-happens only between requests in the same queue, so it is not possible to merge
-requests from different queues, otherwise there would be cache trashing and a
-need to have a lock for each queue. After the scheduling, the requests are
-eligible to be sent to the hardware. One of the possible schedulers to be
-selected is the NONE scheduler, the most straightforward one. It will just
-place requests on whatever software queue the process is running on, without
-any reordering. When the device starts processing requests in the hardware
-queue (a.k.a. run the hardware queue), the software queues mapped to that
-hardware queue will be drained in sequence according to their mapping.
+can read more about Linux's IO schedulers at Documentation/block/index.rst.
+The scheduling happens only between requests in the same queue, so it is not
+possible to merge requests from different queues, otherwise there would be
+cache trashing and a need to have a lock for each queue. After the scheduling,
+the requests are eligible to be sent to the hardware. One of the possible
+schedulers to be selected is the NONE scheduler, the most straightforward one.
+It will just place requests on whatever software queue the process is running
+on, without any reordering. When the device starts processing requests in the
+hardware queue (a.k.a. run the hardware queue), the software queues mapped to
+that hardware queue will be drained in sequence according to their mapping.
 
 Hardware dispatch queues
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -143,7 +142,7 @@ Further reading
 
 - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
 
-- `Null block device driver <https://www.kernel.org/doc/html/latest/block/null_blk.html>`_
+- Documentation/block/null_blk.rst
 
 Source code documentation
 =========================
-- 
An old man doll... just what I always wanted! - Clara

