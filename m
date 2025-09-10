Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191512609D0;
	Wed, 10 Sep 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472245; cv=none; b=bFodUS+tN3SWzmp9KUh2DgG1lenxBd0nNN9kDxF4Y9Mu6tfHUOzhIj9CmLZdDj5Ptd53vuHJKc5zgboNit1U886XYlQoTj00U6OosXQkiPOjhJrSbMaX3+EWnOluWy0Z0Hhj2vaip0Qk+DyPpFsc6/pHlJbPIiifn1wZXU1jhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472245; c=relaxed/simple;
	bh=OYt2QegR/+u0q3CRKm7Zg38q7SY9D/3L6tdzv43Jflg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqXfOpC+NbihOSh0z6PHsRfx1F+Ej/WHxMjy2UMGy1Cob7RxDfUODATof6hB0My7IkEVT04sqshZRsYQXhQXz6NzkprP19+MddnmWvwjVJszFAp5mgHi0SwXIQowuWNhb6Pv3tq2iGMrBFrH6Vms7iFhS8UfDWaWbSMDY+FoyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frIT3D6K; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frIT3D6K"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32da4f36572so1102311a91.3;
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472243; x=1758077043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0koFSnJrv2UowuMhMeqtiJIslvN7BbZv6mHXQ/mKo7A=;
        b=frIT3D6KNXaSuAUHg9pq3zZY2/Y4jzVBPUps82CYLYdwjnt009OJ0zHdOqQtNAfioS
         PKT+ZarJYVR0d8yQ78rfGv7n9ERE6JPoYvnDnYo6U3TYj2nvej7UmE6hE0YFk/fUXS93
         KAcsFdQxjpJFjjWsA59wyDMoNG1wkXERimti9LyuFcEsCplsLNS47v8vMmY+9tlcaedI
         qyn5l6f6RgKAaVdN0FJb14WCIHVlNpJ+y+sm19mrAOOampbQeXOSOiVVuNpsxPbrFFzY
         U36CeL1E1iV0D1RfzyOs2+DQhQ180nhIA3cmsU6iew4xD6vLBPl54ZnnTIj4tMhxAvwj
         K+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472243; x=1758077043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0koFSnJrv2UowuMhMeqtiJIslvN7BbZv6mHXQ/mKo7A=;
        b=aFqTgXYa+2TxHfF1tXilJh+Wj4uFNRnmhd9ZiYu9EbJupqu9B8EOKixI5es7CY45Vj
         4r3XlqUz85emRlOVQvpLqHaPTiAYUjadr4wNd/OUpbR7hTZFAOgnYCJuGzuWUMT9exIJ
         pg23n7wSI41TGeO9doAjEWqQpbPTlRPQcwKsEjA8nDhpN9yZYj/1jWVT2Zt9AN/GPzzf
         poVlo1mJaOELYBcqyWoemhYVOFwBZXBcgaAEUMl67CdQHUaCNO5XtHcklG/hX7XGdhY+
         c7fx10wdgan+ynLKu0dmY0SiJ8LtJ51NzMuC67Q0Rk3C/CmItzw3dgoWh6uRS3ZNi7c6
         Iixg==
X-Forwarded-Encrypted: i=1; AJvYcCUFLAJz8Yg2oOEQ3SXtJCXNzdepiqWsmyLFb/Wzq1YaqFaYULvYkLEyLFfQ5JSF5rN0B1xbYg==@lists.linux.dev, AJvYcCVjI1pq0sv150nRJmTrX1lrmoEHS8wLAmjCrR+s69b1DU5as8q/lxKHShjZVUloWo4s0GI0KGVGDdw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyOq68+x3vTfHTUU7hVmjeDm3b6lPVbmgkberRy/Xrj6htyjkB9
	P4c0+e/6eCsgJUHxZEPC9Ia6DKhLO/H76HqQn8BbT0HT1aUIpD+Hy9JP
X-Gm-Gg: ASbGncvYuKm9NuGCXvjTqglWFwiO2gZRxVsSHMsPj0N3Ts2oONX7Z1FxRCjyJPaukDS
	MGSjtE6DLQuMrlR+wQYZFD2IpqPxPTNPLIlMsNmnEiXjSvj24TFcy90qX98QZq2LGDU2hTz8P4Q
	N6M0Z6G1/4Obyfz4Dc2MfAj3pFlQ912EQqTA96JtJkrIN+kpXeVXF7vVT3zqKD6u7X0RZ2nZs1X
	H9wkTXgIZNzmdBX+y9vToRFXKrAaieQxVGce7FvdUladcyiwVeCE3FqBKCVNoXT8s+p7Ml2SyXV
	NK7YS3iPLHP5Y4foegpuAnCYICgzDPii82rI+KWFKqjIUVMBwfc0N+D2a02t2CKp43uogzePqMz
	hp3X+7sYxA3N4EVvv/8vf5ZuTE+4bcq81XuYS
X-Google-Smtp-Source: AGHT+IHze3NqUFgqDMM+sZM9Wi/Xmfyi7sD03WA5eGHes94PFV7I4KKOuKIIQBvLXj+TekGgIh8lMA==
X-Received: by 2002:a17:90b:1e51:b0:32b:d089:5c14 with SMTP id 98e67ed59e1d1-32d440c5edfmr18323077a91.35.1757472243321;
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbc1c467csm201563a91.7.2025.09.09.19.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3876D41FA3A5; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 03/13] Documentation: perf-security: Convert security credentials bibliography link
Date: Wed, 10 Sep 2025 09:43:18 +0700
Message-ID: <20250910024328.17911-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=bagasdotme@gmail.com; h=from:subject; bh=OYt2QegR/+u0q3CRKm7Zg38q7SY9D/3L6tdzv43Jflg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnijWLH+uxHuD5TvzhcJo65MVRz8evf+ht/Kg8H3eu d3xR8redZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiXd8Y/pkdXvTh5u5HL7eU z3No81zweEv6gxSt+G/HWyxWsM1N7zjH8E/xHeNT5tNsutFpemIVy+M+5pasa5QSXynjZOFf2v3 OnBkA
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

