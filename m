Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478383;
	b=so33WwE55ioqTA5Rvmd9K09bYYXNxble9gyLrMrNefeZM5htba1/Z1Uao1yfJ3Cf1WAl
	 /1Y7K735qvqzjL2aoo184gomZRf2NUHxr8dpELNWvl7NDz4eM/OsJgzoYNA8hrzGd/Iao
	 N83gbojvGrtiDzomkmf2JUW92vih0DTFaC/Y0nDxB4LEcbEB+7rBtlodvsyM8QUwIFmZZ
	 J01UaLuZU9v37Km1Vt8kvClKRq+HQxH0xmnjOnb4ddzOj5rEktAtRBHDLrseFCwqu9Dv5
	 IKBmeDN75lxldwvCe5jK4PGe0+XCpOmPj896KidwWi/j3sTdooonNqtu0wDXObNvPQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b0huW68ClW7zGxTajFYrPJIOdcCJij4zkacprcElp1s=;
	b=DhYEW1UrZNKHUzdKKr/UuIMiHB7Bp536S7B1oExPwNJUNEw7hCHdc2WGX/v3Ho+Bqhr/
	 SMZnpPm1u2YO+mMkhRdBC++ve/VcoHSvDcdvg8+n5WY4N4G+HL4zitDYu+0EfmKZBRu9N
	 3EP8lXw88yHN0A+5Q4nqpFK4Khvi6gTRDE5r/253VhDiGZaaBfyLmn532XHDdBzOkCt+I
	 G5cwFJ5HuN1n4LZuoJXJxzPFV4ILRb22sVNVinfJBm1BGvbHLnwznXgxq0Q2NCkNIzdrJ
	 7jWobvr2cQ5TI3uxCDHg3oc0cJdZS2w4pQWyoYsQ8RZXOM24va6v9b4e6APCZf75cvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FosXs5Zy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947C606A31A;
	Sat, 31 Oct 2026 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FosXs5Zy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163741F000C1;
	Sat, 31 Oct 2026 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478382;
	bh=b0huW68ClW7zGxTajFYrPJIOdcCJij4zkacprcElp1s=;
	h=From:To:Cc:Subject:Date;
	b=FosXs5ZyY5xbW4Vt8TM/mcfwydXXh/ABN663PHVu6Pa+NXbNYlyaRNfyMpyehFD/A
	 h2tvLbUW0QyBnsb2kzHl+zNC5pELZUzqRLfYpmAdJBVNFfwu8Kppiv0b9XQfalqLbi
	 YHy83IUL8RXhX/ydUmE/IrnCDdJHPj1jiGrnrtYApjI44WR1pmekbS86EPBE6MM2H6
	 Bx/XtLng/sPM34p5dtsGwgn3KCzSgx50WoCK9Ocv5GJVzU6Dh4X3WCPNn97KXPR5v8
	 5HOG0AKD4CgNS7hLNuY68i6rILQnmi5fJCCxWPSivXzMITY8F2DwkpQ9dZ9/H5u10x
	 vxc6rQGSORdrg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/6] mm/damon: misc cleanup/improvements for core, vaddr, sysfs and tests
Date: Sat, 31 Oct 2026 13:26:07 -0700
Message-ID: <20261031202614.96036-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor code, optimize code speed, and add a missing feature support on
various areas of DAMON.

Consolidate invalid DAMOS quota charge pointers fixes into single place
in core with patch 1.  Optimize the efficiency of vaddr damos_migrate
action under filter failures with patch 2.  Implement sz_filter_passed
feature for damos_migrate action in vaddr, with patch 3.  Drop a
redundant and racy quota goal target value validation in sysfs, in favor
of that in the core layer, with patch 4.  Drop unused variables and
imports from selftests with patch 5 and 6.

SJ Park (6):
  mm/damon/core: handle invalid target in
    damos_fix_stale_charge_pointers()
  mm/damon/vaddr: advance migration attempt in folio level for filter
    out
  mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold}
    action
  mm/damon/sysfs-schemes: drop redundant and racy zero target_value
    check
  selftests/damon/damos_apply_interval: remove unused variables
  selftests/damon: remove unused imports of os and sys modules

 mm/damon/core.c                                   | 15 ++++++---------
 mm/damon/sysfs-schemes.c                          |  3 ---
 mm/damon/vaddr.c                                  |  8 ++++++--
 .../selftests/damon/damos_apply_interval.py       |  2 --
 .../selftests/damon/sysfs_no_op_commit_break.py   |  1 -
 .../sysfs_update_schemes_tried_regions_hang.py    |  1 -
 6 files changed, 12 insertions(+), 18 deletions(-)


base-commit: de796f0221d9cfc6a468e83934b9514c43b0a4b3
-- 
2.47.3
