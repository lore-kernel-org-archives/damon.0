Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1300F285412;
	Fri, 29 Aug 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454136; cv=none; b=EbhxRGc+VRqm2Xl1tjptR9sYXfq0pbFkbPD5tVQpvX+SfUoFetakgLiTZuBqVESbpetvH8aQZxSRLbLuHc3zFUMB3i4AcruG+h59bgm7Hh+enhxB3nPzp5X78bZj+Sac/tAJlJ9qgGkPjQA8QiyeWe+Mhnnx/LkZeTptE0oC4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454136; c=relaxed/simple;
	bh=oQ/U51BIIgNGsRun+kwInz/tmig5xTqHruGeEvNRxQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3y8+ewm+716inBxYqThUiibZ6wAk6v6HCJT7/C8uHZmqoeg51th9CpRMCAZ8sHSG3dYGurUtgXwPE8P6NitSrL8LCo9QG6di5uNpO4WJ8mSjdjIjaLl/Tck4B4K9Flrf2NXIiBsTn3UkBXqRyPcyf7DZ9wjUQZCALUSF7/c9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQXdZLEr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQXdZLEr"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7722f8cf9adso301668b3a.0;
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454134; x=1757058934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKHUedwTpnE+6902OLKWJUrKeeyE0icmaP4M6h8VeIM=;
        b=OQXdZLErIiPYDuWiF3cTGDcSZWmWWHeTF0ngm99iaDejmnYlYzuw1R4Or8fde6w1wz
         pD37OL74izDGNFm5YqAH0sLGZQ569LV/Dc2d1hiYxMc1HO3oTu0de96Vw1efLw5nJPLk
         Y7OPdBzpphKqRwhzrUbreH2zllonifvbLp2DsHD3/L+PJ30MC8g9LAW1IKBri9GWatV7
         W4iXXuu5J6SCdBRv+pMXZ3+6oBJLvZ0o+mLRJMcmdYPleYkAMc3RmOrIstk1Wg71DK4H
         xMYpQkDGAEq6+M1n4/+wwgyqEP0aY09zFQoTc839R7aG9GR+7Djpf9aaR3AvU+4ektf7
         x7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454134; x=1757058934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKHUedwTpnE+6902OLKWJUrKeeyE0icmaP4M6h8VeIM=;
        b=lIuCT2U0EiwppjeQFt3VsgQ6RRhES8f+KShnQoa9ucRgfC/r+lCBHlygF3kCmzVPJu
         W7s1G+Uk0diHOiau70bx5PAlX+Bd8Iaxm0Bmb0TcCoUh5gj43B2nUCzGjNx9y3AF7tZL
         +KMeoAgU6z3WbdSC9DjDL2noFktqXntPpXKt0S+7yLnr36kA86c2FcypjqSpIZJF6Sxq
         QDsVpQMsmJD7esdMcjURwss8rqZVBMHgatR3GJFIU/1Tw1wQ7rkyGE1n4Pt4A0xXkukh
         2FbYg2+rGaBiq/M+nX87W+evF/cjbDgNjpJTZidSngN5qDYBHOgag3nEwfOAXfurKeeS
         //Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUtYMk0wqjerdEw8dT89lkBJdncD1qmpIm+K+86ZOKS071Kpaer9JYHwrQQVA5MeilaWIjZCw==@lists.linux.dev, AJvYcCWbLHcZJYPFqFPlbpk8bF2rDvMJsRqqPAkOJ8QPFsZGdf/AgY/oMAI6t83zLMX0RF8ucCSMXWXwxqw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyCE7U/bnDlWrLLuTIE+YehE13degO/mhYfpnu5Mmflhlgk+/GY
	az9AezC0H/BrHdrLajj5NYCbOrJrN1W7zMCa5i0lVfo2DNjaloGsg2Ky
X-Gm-Gg: ASbGncsjNs1RbB64KPwGxGCQOryva4rfsvOqc2e3SItL7esmu3JqcM+V7Avg1V4Q6KU
	SUAvSazUUOqy8mZDBPk9744UxU0F/HP1OYLccWJYS5UQVK3BEUzfHf8XpT5QwyB38EJ1wb67MAs
	1cCf1AUVNvSPLhu0+xLr2fXM34Z+qndKDbyDrdJud8bl26aaE/L4ln2p4XE0pXkmAjgsbHtuCCr
	YB97gmMOqEKPlPI6viGPVzvZovkgG6dcb6omzLnxzfAlRoh4zdCedY95Rs0aeL1/+THc6Ih3w2k
	+0qQUFIxXqTwS6xjWMpd0ChS3f73lHH+4rQo80HpxInB/9+w4GhjIQhtImX0bRl2K4Or+40o8Ac
	MzuzZFDaJywC1XLH3RjmbH9rz0A==
X-Google-Smtp-Source: AGHT+IGAIwvY26FUOsw+74AGPHA13vcCLFsNdM4e5R6RQVZDqKcVncdSUEtOIO22R3FiVyKLzy1QwA==
X-Received: by 2002:a05:6a21:6d95:b0:243:9824:26f0 with SMTP id adf61e73a8af0-2439824377dmr17475585637.46.1756454134181;
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd336dsm7401665a91.18.2025.08.29.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CE9134016442; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
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
Subject: [PATCH 01/14] Documentation: hw-vuln: l1tf: Convert kernel docs external links
Date: Fri, 29 Aug 2025 14:55:11 +0700
Message-ID: <20250829075524.45635-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=bagasdotme@gmail.com; h=from:subject; bh=oQ/U51BIIgNGsRun+kwInz/tmig5xTqHruGeEvNRxQQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY144a/JZLY81M41OfrJ5W/1jtyyro8lZM99fCflwN Zg5yrW3o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABMpCGH4p3zu88Pdlu95fhsv /CZ2ieHwual5ab7C13i5XivpL/Ip/M7IMI9vYUN6A5f856j5POvK+r6kxCYoXlPd7vthl2/zPqb NrAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert external links to kernel docs to use internal cross-references.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/hw-vuln/l1tf.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/l1tf.rst b/Documentation/admin-guide/hw-vuln/l1tf.rst
index 3eeeb488d95527..60bfabbf0b6e2d 100644
--- a/Documentation/admin-guide/hw-vuln/l1tf.rst
+++ b/Documentation/admin-guide/hw-vuln/l1tf.rst
@@ -239,9 +239,8 @@ Guest mitigation mechanisms
    scenarios.
 
    For further information about confining guests to a single or to a group
-   of cores consult the cpusets documentation:
-
-   https://www.kernel.org/doc/Documentation/admin-guide/cgroup-v1/cpusets.rst
+   of cores consult the :doc:`cgroup cpusets documentation
+   <../cgroup-v1/cpusets>`.
 
 .. _interrupt_isolation:
 
@@ -266,9 +265,7 @@ Guest mitigation mechanisms
 
    Interrupt affinity can be controlled by the administrator via the
    /proc/irq/$NR/smp_affinity[_list] files. Limited documentation is
-   available at:
-
-   https://www.kernel.org/doc/Documentation/core-api/irq/irq-affinity.rst
+   available at Documentation/core-api/irq/irq-affinity.rst.
 
 .. _smt_control:
 
-- 
An old man doll... just what I always wanted! - Clara

