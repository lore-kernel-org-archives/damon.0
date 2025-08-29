Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642A5285079;
	Fri, 29 Aug 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454136; cv=none; b=F4k4CX6n0UrCinC4vKaBtHP4hCYHu9lSRmf4UIZt9tcohM4c1tXg64jx76Ug0HJxgU6cq1cgAzEi83/mjgTYBsddMw3Bh0hbjL4pFXUifEYfBHDaojUzcl7FH9rqhmYjhWsA2nCjorRygPhFoOM8PcVvpbQRZQRE9t77N0IX3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454136; c=relaxed/simple;
	bh=UJUK8/oCaP8or4xMM6dYj2gtHalMI9xq0zTRRM+Er48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQvZ1G9ecPqnXZg+rVVzVsDNpKcJQ1fObEzlTBXSdyJphpfsmHGTXkUqSdyAVIjigHHnNYSkVO+yuwc+a5FfCeVpTRW83LCc2cYrM9xvQXCYajhbkYGWN2UjcBfUfAzWUpvpYXh6yD2/M0lKQA3VL/pIMjpKLWxvAZQWYmKE8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7mzxIaS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7mzxIaS"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-246648f833aso11818045ad.3;
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454134; x=1757058934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1dzl/9HN9fCmWWoku2EUAe+4oZJtgdEcU9UZmXN/7A=;
        b=I7mzxIaS44E2M0haVPAdsK6azfyI6aFzGFCqOJ7b3Ai9oe3aJRn4id5X2qB07g7AYO
         KMptdGjPm8ZS26E7nDCTGCTrm4gv6NPb0GvnSRbTH3UaaHMIdYzasB3bz+ICIYf5GgNp
         gKU6jvOksMJfPY7mJtI9fy/k6/6KETuwPa4mqcsaxNIf8fI87tvGZRLxdupJyEgEYScg
         R+z0GAHUsrnkKAbhVJKPVG3bcFUBvNVwtSJEveXr3sWXxiHhs5JvZWUw841qYWQeqsx2
         MnXZNywo1Bn5e1MZIH9e0b6SltcquvSYJZIlS+mX1YkZWEckL6oY06B8eEZIy93xgtjD
         qR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454134; x=1757058934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1dzl/9HN9fCmWWoku2EUAe+4oZJtgdEcU9UZmXN/7A=;
        b=wXH50YTdA+YRFRUc5YKxfhKwEBQClzJY7uo6GNmREExsNHSgi0PrqAJIpVZcMNYNDX
         wmlJkRYgwEbeMvcQjZQ9vMK9sbxhR3v4H+RoWf/4CTY1GIGFceqo8rwzRgQc/z2Y9GF1
         ttyzVzversrESEE4DZLSFYbpiiUTYRED2uLARLsEmFRUNBMcrbCuEIOEfef906msFs/u
         fu5ATglCDzYrtvNqG5Mj6RPCcDdsHGNtEeJAdqfUCGQg01AUhyLhDs2pifl+VfuHA5+2
         TMXnq7umw2z1iwTXSmUoFhBvSDxLhSQ8h5O2hzasg0jY5YboAu1ZTPGmPyuwQHUtJFwy
         CIbg==
X-Forwarded-Encrypted: i=1; AJvYcCV71SYibJI/lvsptK/TMiSlHYLHEjHqQcNhv7+mS7tUQ2yqIXSGc/3Vogil37fDkMeEilcqBb7WqDI=@lists.linux.dev, AJvYcCVv/f7L0xQfzX4X8ozjDWGlFf8oyiYCLb1LheIPXmnJVmkKi+jOxxwB3cLtRgZ+kmvP88lDyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3zEZSkMDRBFzOu70vDONx7odlj2D1FvRHX7+120y3mXGROjuM
	3h4PmWVRk6BiWN42bL9e9L4j3BMYgQvSAPMrBLjgeHbwN0toKKEPTecq
X-Gm-Gg: ASbGncsBwfVHuGfIIDkSsPd/akUWXXcFQNtgbs9I8Hqyf1/d3nDNQDadRf/edUgrdG9
	1gpKs+Ck6mQo9cjn/TNrejviVIu30sH2RTUkNTK6vX2CxQEijdSUF5VFrivfVXEdnr5eUY50FN+
	CeF0WW1rQSSkQB/k0Q7DkXOz4MC+nW2slLQ29MD1fVHo+BIBuYlB1AEoyhKfnBYBtt82N6lpdNE
	NQXNC4gatl5tu2gNd4d2C1LK7KghDpFkzCBGNDVHZ1kW7a7XLC3wXCnrrborGSh20KwGY57QGm8
	t8v4QYozlED0uTwgq4dP3n9O+gv7aprb0hucWxdE7hKDlvLdNwuU/5Csj2jAeODxMd991p4Tgtp
	oaApHTH9/zz1JzGYqk8OYZAJxC0BO5ycPj8yD
X-Google-Smtp-Source: AGHT+IHHspv4kBSvuOju+syLfWNvxBR1WSkz7mrwJNK9paKzC+4NcNK8VdwZC8CcLSepusoSJLIitw==
X-Received: by 2002:a17:903:15ce:b0:246:c7dd:8da7 with SMTP id d9443c01a7336-246c7dd91f6mr219457635ad.32.1756454133503;
        Fri, 29 Aug 2025 00:55:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037043b3sm17009045ad.22.2025.08.29.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 92CC9411BF96; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
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
Subject: [PATCH 00/14] Internalize www.kernel.org/doc cross-reference
Date: Fri, 29 Aug 2025 14:55:10 +0700
Message-ID: <20250829075524.45635-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498; i=bagasdotme@gmail.com; h=from:subject; bh=UJUK8/oCaP8or4xMM6dYj2gtHalMI9xq0zTRRM+Er48=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY17c4br6T35GuJHFF8Yt24416R5lZZr0d5nIjOkLd Wbtjd2k0FHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJxIow/NNvVZZWvf59gvln 8f09a96zlV1ddP/qfkeet3OelO1bF7GW4X+WSslpN8ZtovrZdcGNj+0m353MlHX12bkXf15P2h5 ctoADAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Cross-references to other docs (so-called internal links) are typically
done following Documentation/doc-guide/sphinx.rst: either simply
write the target docs (preferred) or use :doc: or :ref: reST directives
(for use-cases like having anchor text or cross-referencing sections).
In some places, however, links to https://www.kernel.org/doc
are used instead (outgoing, external links), owing inconsistency as
these requires Internet connection only to see docs that otherwise
can be accessed locally (after building with ``make htmldocs``).

Convert such external links to internal links. Note that this does not
cover docs.kernel.org links nor touching Documentation/tools (as
docs containing external links are in manpages).

This series is based on docs-next tree.

Bagas Sanjaya (14):
  Documentation: hw-vuln: l1tf: Convert kernel docs external links
  Documentation: damon: reclaim: Convert "Free Page Reporting" citation
    link
  Documentation: perf-security: Convert security credentials
    bibliography link
  Documentation: amd-pstate: Use internal link to kselftest
  Documentation: blk-mq: Convert block layer docs external links
  Documentation: bpf: Convert external kernel docs link
  Documentation: kasan: Use internal link to kunit
  Documentation: gpu: Use internal link to kunit
  Documentation: filesystems: Fix stale reference to device-mapper docs
  Documentation: smb: smbdirect: Convert KSMBD docs link
  Documentation: net: Convert external kernel networking docs
  ASoC: doc: Internally link to Writing an ALSA Driver docs
  nitro_enclaves: Use internal cross-reference for kernel docs links
  Documentation: checkpatch: Convert kernel docs references

 Documentation/admin-guide/hw-vuln/l1tf.rst    |   9 +-
 .../admin-guide/mm/damon/reclaim.rst          |   2 +-
 Documentation/admin-guide/perf-security.rst   |   2 +-
 Documentation/admin-guide/pm/amd-pstate.rst   |   3 +-
 Documentation/block/blk-mq.rst                |  23 ++--
 Documentation/bpf/bpf_iterators.rst           |   3 +-
 Documentation/bpf/map_xskmap.rst              |   5 +-
 Documentation/dev-tools/checkpatch.rst        | 121 ++++++++++++------
 Documentation/dev-tools/kasan.rst             |   6 +-
 .../bindings/submitting-patches.rst           |   2 +
 .../driver-api/driver-model/device.rst        |   2 +
 Documentation/filesystems/fsverity.rst        |  11 +-
 Documentation/filesystems/smb/smbdirect.rst   |   4 +-
 Documentation/filesystems/sysfs.rst           |   2 +
 .../filesystems/ubifs-authentication.rst      |   4 +-
 Documentation/gpu/todo.rst                    |   6 +-
 Documentation/kbuild/reproducible-builds.rst  |   2 +
 Documentation/locking/lockdep-design.rst      |   2 +
 .../can/ctu/ctucanfd-driver.rst               |   3 +-
 .../device_drivers/ethernet/amazon/ena.rst    |   4 +-
 Documentation/networking/ethtool-netlink.rst  |   3 +-
 Documentation/networking/snmp_counter.rst     |  12 +-
 Documentation/process/coding-style.rst        |  15 +++
 Documentation/process/deprecated.rst          |   4 +
 Documentation/process/submitting-patches.rst  |   4 +
 Documentation/sound/soc/codec.rst             |   4 +-
 Documentation/sound/soc/platform.rst          |   4 +-
 Documentation/virt/ne_overview.rst            |  10 +-
 28 files changed, 165 insertions(+), 107 deletions(-)


base-commit: ee9a6691935490dc39605882b41b9452844d5e4e
-- 
An old man doll... just what I always wanted! - Clara

