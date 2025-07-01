Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A661F09B6
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360066; cv=none; b=SybnCEhmxgGq4NXz/Zlu4QHZ9hrSVnbydQ2VUMEUnQF2E/nKbaoY7O53ksFz1nQkwmwsBDW8+9viMvgD58h5YzAyMd0O+YSlAxLvle9PnsJv/RZABdwGqS/YbGsuMzSqIX+rAp9Bm6B76xGNixC626FIgafuhnnbhXw8G95qM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360066; c=relaxed/simple;
	bh=VR14VkMWjb9DHNvf1mo7LmnCvrJGGj2N9m6UdgkX+EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c612y8Yau9b5Qr6A88jQGbt7NTTXoplpajCqz+k9QVHfdWXZ2yLfe+3gB7DRJ9jLFqY3+ubE0ga1CA2YSCfRO3RmWKILoOKaLh6Bk5ezGzPVS1vXfzNeN5XddX34rGXN+Gxkh6nm1+G326AdP6qwp2ehragb3s02KI/58cqSg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-74-6863a23c1bcf
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: [RFC PATCH 0/2] samples/damon: improve expression of target region in mtier
Date: Tue,  1 Jul 2025 17:54:15 +0900
Message-ID: <20250701085417.1734-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsXC9ZZnka7NouQMgxn9ohZz1q9hs3jy/zer
	xeVdc9gs7q35z2px+OsbJgdWj02rOtk8Nn2axO5xYsZvFo8Xm2cyenzeJBfAGsVlk5Kak1mW
	WqRvl8CVsfhbA0tBP2fFw94VzA2Mp9i7GDk5JARMJI4u+8wEY194txYsziagIXHw0ElmEFtE
	QFCi//EM1i5GLg5mgbmMEkfOvGcESQgLhEi0rv7MCmKzCKhKtM+YC9bAK2AuMfv1OkaIoZoS
	DZfuMUHEBSVOznzCAmIzC8hLNG+dzQwyVELgL6vEyS/PmSEaJCUOrrjBMoGRdxaSnllIehYw
	Mq1iFMrMK8tNzMwx0cuozMus0EvOz93ECAy2ZbV/oncwfroQfIhRgINRiYd3xsmkDCHWxLLi
	ytxDjBIczEoivHyyyRlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbB
	ZJk4OKUaGBlDOp45PG2Y98ApfT6P4PTw75q33r25IvD5r7esRR5TkOLOEz/b/x0/c5cxrcC3
	pn/fn+erK+4lGsT6fdded/+ORe2RzL7HhtdXRW1c2nO780nwB9at986pnvrqcKHqgUlnWf67
	uAymB7v31pgxyb/Y83uzTO3BO1eWtiwS3Mot1OSfovvitowSS3FGoqEWc1FxIgA/rDOiMgIA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LhmiGro2uzKDnDYMMXDos569ewWTz5/5vV
	4vOz18wWh+eeZLW4vGsOm8W9Nf9ZLQ5/fcPkwO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfG4m8NLAX9nBUPe1cwNzCeYu9i5OSQEDCRuPBu
	LZjNJqAhcfDQSWYQW0RAUKL/8QzWLkYuDmaBuYwSR868ZwRJCAuESLSu/swKYrMIqEq0z5gL
	1sArYC4x+/U6RoihmhINl+4xQcQFJU7OfMICYjMLyEs0b53NPIGRaxaS1CwkqQWMTKsYRTLz
	ynITM3NM9YqzMyrzMiv0kvNzNzECg2lZ7Z+JOxi/XHY/xCjAwajEw2uQl5QhxJpYVlyZe4hR
	goNZSYSXTzY5Q4g3JbGyKrUoP76oNCe1+BCjNAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNT
	qoHxeJmT+ntv9mWrDba92hnx/8oPozCGzVI5E0K/zO2ud626/++c4Poo6UjnU5znrv9R2hDl
	dkDsQ8ud8MXrlfdPD5m61pCD+5JFwwH5540Kyzcv3q0rEd7VebZq8ZYJ+n6XZetWC1W1t/pZ
	Hag+wf183vKXxzrm/fn1K2/aLD9Wy/8KacffmtXZK7EUZyQaajEXFScCANhKO8siAgAA
X-CFilter-Loop: Reflected

`mtier` module is a static module for migrating pages using
damos_action: DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD. Currently,
this module is built on the assumption that the system has two NUMA
nodes, where node0 is the fast-tier and node1 is slow-tier. This
patchset aims to make the expression of the migration target region
more user-friendly by : 1) allowing users to specify just the node id,
instead of physical address, and 2) adding two new knobs.

Patch 1 removes four knobs, `node#_start_addr` and `node#_end_addr`, which
previously required users to input the physical address of the region.
It introduces logic to conver NUMA node ids to physical address.

Patch 2 introduces two new knobs `migrate_hot` and `migrate_cold`, which
specify the source and destination node ids in a comma-separated format.

Yunjeong Mun (2):
  samples/damon: convert node id to physical address
  samples/damon: add `migrate_hot` and `migrate_cold` knobs

 samples/damon/mtier.c | 108 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 93 insertions(+), 15 deletions(-)


base-commit: db16fe88cdf83a1e7fdf75de282025b6ad61d08f
-- 
2.34.1

