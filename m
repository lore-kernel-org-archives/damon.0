Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970D28507E;
	Fri, 29 Aug 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454578; cv=none; b=Q2bNWry5F8XqrBFcFLmwYvqfObKb9Ue34U+mGzFooc0DChiZuvwdIfH1u3x3p5NJHKYpaleeCFhS3UDoLuhyOtbM0iufOh3+ZQaiu7afo8S1NXCF4DRSupMYYC6uOahOSb2TEnib/C2b9IE6ii7rJU5urpSeptuHsYy2PV/Lcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454578; c=relaxed/simple;
	bh=tVZea1ikNA4Sssls4g09ZchJ08JhUaFOY8Mmt8T2Tzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmX4sT8XfC2MuYioqeeOGyHHT4g6MTD+/ebpveH8zeuyHURa22/Eg+PL5qihVfrh7ziW0eb0dv0bjdGkLvphXYsSbYoKOhTNyEfbi4zqGg73y2krf25lhMaNHhD0Z9q4FOaftOT/QoLtUjsCViTZKtT/AxSXjTjKND/FLAS2cEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+5zI6Cu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+5zI6Cu"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326793a85so1511338a91.1;
        Fri, 29 Aug 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454576; x=1757059376; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdhbTSK6p9ht0YngyCDiyyRtcLCfpgxS9tGDrcGiJGs=;
        b=h+5zI6CuujaU47iFuO6UdOjdohfGHAKaTFM8N/EWqHz2iddRxQH/RQ1/0jN4DopOj+
         m69/qcU4Er2eKjhVL+sg/vfvs/+qd/CSgg4TIXYo7J3uFvhn1QlThJRK20nSztKiBR7l
         LbvDvf2aCWW0hY7dfBabcZL1udtIM8IVEb96wFN9qzSSG6Q+Bf+Ls22f/T85kpWj+uBy
         Cmgv2ULy04lOcKf9EMhhT5I0l8QXYwkyjEt9t0Kz07RO07wIT/YIKb3gZSpTmssYTch/
         r5tu/VR921a6oWnLkADtwvHT+iWwyVDLK1MPsG+SHZHiVsdNm6MFKyzPu6VV0yqFp44F
         RShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454576; x=1757059376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdhbTSK6p9ht0YngyCDiyyRtcLCfpgxS9tGDrcGiJGs=;
        b=n6vA0fy2Vc9ko6MW/9uaHImmyU/NfXwQ3QcoguiBNHA2GFq8hPj2Hf1i0zZGxN9Q0X
         xlgxYBXyCK1s3K5AxTQYXGZaNBAKHboz0EoFEEFIWM/Dr6AP5S+v4GkXLNFV6mADVNv+
         aLs3WRiAcXyOUWNo60pBku7m5263xWxix9YPrUmjSIIGDGNBFzomqPYJ0QjDjjiIF16A
         f3JMpYAGWCUJUhgjGyoEL621L57CWhkMcUHRAzFpqabO0nVsiO7LuqoBM1lfEQEh+H0k
         FG1lD3wpoF3xJy0vYZ2ENgQryD8xhgFZ08bItXE5ss6MlVtYzgJjeILkTsL5O7G/+OvE
         66cA==
X-Forwarded-Encrypted: i=1; AJvYcCXIh+T+TYvWmuOx299JEft9wcwMn5HlkwXzhH2moU0P0RM0Z2npSHCkqg1WTs8VZ9yJOOT5OuzoILI=@lists.linux.dev, AJvYcCXc/KPQx4gVCsoT9pEnTsiyGZTAR6q3kUaWqKi0axqFxNKc/qvvNleKY/91YCQLrxf0LFBsrg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb9INbdvSFjaXjk+KglFuRDqI4xyWwz64+oDUbistVa/TKgDU/
	MF6MJcLkEinSnIStUlU2zhAwnBWeNxaVt0f2RsMjQk+cEHiCK0hba64Y
X-Gm-Gg: ASbGncvCXYtqaZKJnmIipeR+tI0TZ0iuust0q1Bp3Lt8eq0KDewivuJyybEj6jUm8w0
	m0B4fxAE5fA0z3LOz7II9iczKSKsGBcIvGG0KjxIvqnjYONEWPML9OEOtvWt96NvILo8prRc1JH
	e9qE89XUcgWaSosxZUbaQR7rUOFkE/+AcJhv0pCXfgaJx6HWHR7oq/Wfavz9c7ZMCep+0DD5r5O
	ugW+lPe+nsx5KesAuoauAvK4d6QGA8fPIFidtrTUawQAq4EETS2TQDclRDJF5vUTSVYIQGp6wg5
	OADU2V+Yq5ZifMFmt0gnEw9A7py6uALnj51giqIOKa1JgQHidysVBtEoe0TKJLWlJvYbWSKbQJz
	2f3Ua+Wh//KU7g0OnF6/hrtORGmERLSgfFuX/
X-Google-Smtp-Source: AGHT+IE+D5SeDqchp/24MDHXx5CQWTZci+ASgYtlboM+vs82gW00FOC1mk2B4v9sodvZwpxdBzPuFw==
X-Received: by 2002:a17:90b:3a87:b0:327:c9c1:4f2a with SMTP id 98e67ed59e1d1-327c9c1642bmr4975594a91.27.1756454576161;
        Fri, 29 Aug 2025 01:02:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327b01e90e5sm2191228a91.1.2025.08.29.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:02:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E8F6644809A5; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
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
Subject: [PATCH 10/14] Documentation: smb: smbdirect: Convert KSMBD docs link
Date: Fri, 29 Aug 2025 14:55:20 +0700
Message-ID: <20250829075524.45635-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=bagasdotme@gmail.com; h=from:subject; bh=tVZea1ikNA4Sssls4g09ZchJ08JhUaFOY8Mmt8T2Tzg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY15VZXUEfpV/XXVSre/C87lNIRyCV5IjnItu7ShZU PiphvtYRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbSt4OR4WixGWdF367Ci0f0 5/VHVx3YxHrvMF/c3LtfDf1enBJSvMrwV9hALHj9kQNbWF8l9WcGsahNXW7scuzOjYlmr0LWbpu 3gQUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert KSMBD docs link to internal link.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/smb/smbdirect.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/smb/smbdirect.rst b/Documentation/filesystems/smb/smbdirect.rst
index ca6927c0b2c084..6258de919511fa 100644
--- a/Documentation/filesystems/smb/smbdirect.rst
+++ b/Documentation/filesystems/smb/smbdirect.rst
@@ -76,8 +76,8 @@ Installation
 Setup and Usage
 ================
 
-- Set up and start a KSMBD server as described in the `KSMBD documentation
-  <https://www.kernel.org/doc/Documentation/filesystems/smb/ksmbd.rst>`_.
+- Set up and start a KSMBD server as described in the :doc:`KSMBD documentation
+  <ksmbd>`.
   Also add the "server multi channel support = yes" parameter to ksmbd.conf.
 
 - On the client, mount the share with `rdma` mount option to use SMB Direct
-- 
An old man doll... just what I always wanted! - Clara

