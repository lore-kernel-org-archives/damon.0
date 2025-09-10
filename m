Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481E2571C7;
	Wed, 10 Sep 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472246; cv=none; b=NgmuoznyO4j2AYDaixXJ6+Zv/GlzNu+YGQmGSWIMJAz36AC2ebq5FxF16aC2eogBQcNVyVi4JkGvAHVMiNTyKZ6+z7al8xe8WUDC+kjBLRlUMe3tsF0h0OdXvQCf8Pygg90Vb7vQqYPRrBDXRIagp1Bzznwz2/SnCEgsp7tYMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472246; c=relaxed/simple;
	bh=IiAjp2UiG4E4i0m+2wynqH3PCAcCcaK0of1KdBtx1KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfC55fKA5DAsoe+nbmjUuExbYkKJTdy/71XQ9LFk2Ubzw82NePzw3zI6mL0N3GyVT8SJl8L+L0XtSIomMnMrS/Sk8DFv5vuNSNnG+5YkNekpCP92RDI3TfVjW1uRAxdiGEc6z/MpRmyoJwNYFPTwgr3mUCsAHLRorhqIoVk66GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPy0INfK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPy0INfK"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266cdf64so5473250a91.0;
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472243; x=1758077043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNDvUkQSM5YXWXIzm38SWG/hRRo/bsx6SYKE7k7lSmY=;
        b=IPy0INfK/WBGs9DE0cEcHndoKi8Dqkh07Q3FpVj2ds+kvNhtSXEwcsUyFnlDjRufaX
         83hh0PUfVtwkEKe4DIgLOKUK7huPzcxi4HQB1F/AW9xpUn47CGTWR419K+hpanMiQ+Io
         MpyHFldOWPAl4ushJcAWyI8xtAVhMtwS5yAS/LR+Ja0qVNhorSuRSSu3vYy+uZox5Xin
         aerkrI70Q0SFYkhEJ1XOMg4KgYadApM26GHHDh4aDR41T2UskP4v5mVK/t5zoAhXCtim
         SVphPIvvcVkO8iNZugnM8PUdOMZ9aVD+p2Pxkvfx4AD9u0IMI7PC6QnqX0KVPVIf34w0
         QmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472243; x=1758077043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNDvUkQSM5YXWXIzm38SWG/hRRo/bsx6SYKE7k7lSmY=;
        b=nm8FLbX9rFB6W4HsscRqTic08pRCV5fjfl+1rvM9qX5pu2Ts0CAtDNnuKKPSjjKUpx
         Qy+v2fWSS0zm0jZGxnaeZIkFK1Mcc38R0WUAsDQQU7tKuzRrMluhX3/YP9NCf2uUwUgO
         1JsPT+BfC11U656ufTfFBgwQG4LQVWT57B8E9T/ks7ZGU3rgNoWqotCejEFgXhsRsuF5
         /Ky8ZgT7s/YUGaqopybEVWJSLWQ/nRyYIuL3oBBgfrRmboIHcKdwDXGAVZd9RTn8hcWL
         tt+gwpKgeKO1hDYRHziALQ2ekuilc7vLv8XLWEUmNL4JtXJERmIL2JVJA9I0Bt4P2Qci
         lr/g==
X-Forwarded-Encrypted: i=1; AJvYcCUBUb0LIN3FdNJHEtvsyEiEMtzD32eiMGqkVB7OBH7s/ah4wL+mX+aqouCsQXCVu7DSJK4z6w==@lists.linux.dev, AJvYcCUa/jOr9Gs+0ew/67qk7Rr3wrmX1COJxOi23r32YmxreyaOwL3j5wFftgH5oZWYnws4k7FXI/oBrnI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyTqxxUaZfox7VkYWpIZBx9V9bRYD9fCT+iAAdrBeh19J9lnx/e
	XZZwr27plAZcLWe8jF3o1Z4zwDtn59I0DOkQqhybtQEfgRtjbySvtG2u5XvFdsgiDvQ=
X-Gm-Gg: ASbGnctK5hdeHupJfUaS8C0LGJ3Ln92Uc7VJP+MqwR8SnBBDOeXkewchoWyJaxHI2xJ
	1yT63JO//FE4MULfeA8VdvcleReQ8UddnxFEK9uTvzzwwP7iqs+iXlthqKg51vueo+tvWCtb80B
	YC5Lr1E0+ohyIKHwLQlFqE3lZSiHj6dVC9PrAvTQF4EW4J6G/YLG8oGZoas7g/3YNQe0aKfB9yu
	lXT9SDSpA37Ahu0IFcUjzrQfbgygN5woq+Gz4fF1lNogs2iRzzRdclDU7+F4DTbMo+n/GmO+645
	fjFejnK77t8x2mMrsaRTaR2BegJz3quxn9phgyydGF7JRCONH6bS3QNc3bnS2OoNS5Nmwj5ECLN
	7LCW3AeNueqbwod5CgnrXOoL+vjke3Lb+lPrnalpEJCjALs0=
X-Google-Smtp-Source: AGHT+IHufov4+itUSgW37fW7I5+vYPKYGEYLT2O7M4oMOCb3e767p9iSPZEDIcWxDU07PyMVD30Hjg==
X-Received: by 2002:a17:90b:48cc:b0:32b:5ea2:a4f6 with SMTP id 98e67ed59e1d1-32d43ef0806mr17274237a91.6.1757472243216;
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32daac59f19sm1672020a91.1.2025.09.09.19.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7D27041BEA9C; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 06/13] Documentation: bpf: Convert external kernel docs link
Date: Wed, 10 Sep 2025 09:43:21 +0700
Message-ID: <20250910024328.17911-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744; i=bagasdotme@gmail.com; h=from:subject; bh=IiAjp2UiG4E4i0m+2wynqH3PCAcCcaK0of1KdBtx1KU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnii1Whs7TnrT1LggM0BOd5LEqfAiXtc37zS3e5gl8 vnwGP7sKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwERe5TH8D8jY+cG0Uf3udDP5 nmfVwtmWi5mup+fF7AiUlLjK8OXNJ4Z/BmfN3s08dUKM70wua9O148mfqhVc3wuvO6WtdrV4s/k pLgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert links to other docs pages that use external links into
internal cross-references.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/bpf/bpf_iterators.rst | 3 +--
 Documentation/bpf/map_xskmap.rst    | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 189e3ec1c6c8e0..c8e68268fb3e76 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -123,8 +123,7 @@ which often takes time to publish upstream and release. The same is true for pop
 tools like `ss <https://man7.org/linux/man-pages/man8/ss.8.html>`_ where any
 additional information needs a kernel patch.
 
-To solve this problem, the `drgn
-<https://www.kernel.org/doc/html/latest/bpf/drgn.html>`_ tool is often used to
+To solve this problem, the :doc:`drgn <drgn>` tool is often used to
 dig out the kernel data with no kernel change. However, the main drawback for
 drgn is performance, as it cannot do pointer tracing inside the kernel. In
 addition, drgn cannot validate a pointer value and may read invalid data if the
diff --git a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap.rst
index dc143edd923393..58562e37c16a01 100644
--- a/Documentation/bpf/map_xskmap.rst
+++ b/Documentation/bpf/map_xskmap.rst
@@ -10,7 +10,7 @@ BPF_MAP_TYPE_XSKMAP
 
 The ``BPF_MAP_TYPE_XSKMAP`` is used as a backend map for XDP BPF helper
 call ``bpf_redirect_map()`` and ``XDP_REDIRECT`` action, like 'devmap' and 'cpumap'.
-This map type redirects raw XDP frames to `AF_XDP`_ sockets (XSKs), a new type of
+This map type redirects raw XDP frames to AF_XDP sockets (XSKs), a new type of
 address family in the kernel that allows redirection of frames from a driver to
 user space without having to traverse the full network stack. An AF_XDP socket
 binds to a single netdev queue. A mapping of XSKs to queues is shown below:
@@ -181,12 +181,11 @@ AF_XDP-forwarding programs in the `bpf-examples`_ directory in the `libxdp`_ rep
 For a detailed explanation of the AF_XDP interface please see:
 
 - `libxdp-readme`_.
-- `AF_XDP`_ kernel documentation.
+- Documentation/networking/af_xdp.rst.
 
 .. note::
     The most comprehensive resource for using XSKMAPs and AF_XDP is `libxdp`_.
 
 .. _libxdp: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp
-.. _AF_XDP: https://www.kernel.org/doc/html/latest/networking/af_xdp.html
 .. _bpf-examples: https://github.com/xdp-project/bpf-examples
 .. _libxdp-readme: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp#using-af_xdp-sockets
-- 
An old man doll... just what I always wanted! - Clara

