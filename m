Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2AA385D91
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299878; cv=none; b=UEF28czny3SFN69YwHfXkLQw322zstERBdvYMpAOhe9FkU/81s4sunAhqlFJyCSlCBSlLTMPx7siiq8+kNcCh37WLh0Xfr2BxCIMiEedsaEe5dit1kE4fIieGqevyx/2rz86oFQQpKVsgUgOAcFNh/3ou/ki0yoHI6PHqPCQHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299878; c=relaxed/simple;
	bh=0aE6h/5Gor35FT0+47VDSaRxZdUotrOoDslgItJm8PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuW2A9Dl1GV+SsJEgGWqbZpKOYsYoFohCmtzwUkgdNKGHcqxWVA0QI1m7DqZV32qX+AQPIEq0TuJVBKp/b6p3uEjsMKIJ8lOnNBtYMsKtIy4bHJCMCdI6UdYj7kVwDtDPQ2L6aL+1pL3D0NxkJoM9dzst/Q/r2/XMeDLdq4f69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lKGH9+qz; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lKGH9+qz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780299863;
	bh=ea62rNturdRY4XhPqvTtukJW98iV/DZwMOLJ/F5D8vs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lKGH9+qzxR6BqKgQYyWPDZB4GRKf6naO2Xjo6aYm6KoVPkdOX6us8OO4Wc4JQG4bS
	 C+kcmUgGen8IUJqh9HYhIA8vxBqPYcYy1a3EVUr6IhUHG6UxCufBpxwIGNDdjw4xYf
	 S88yQsJGo7/3I1r5zDT1O4xr7Hcfn7DB3ZsCiTT0=
X-QQ-mid: esmtpsz17t1780299852t8a43b288
X-QQ-Originating-IP: gmM8c5FYkGEW54XQ/Bl+R6t4J3ntVyb/FQs1oeeHjCM=
Received: from PEN1097 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 15:44:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15633326993219006780
EX-QQ-RecipientCnt: 8
From: Cheng Nie <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com,
	niecheng1@uniontech.com
Subject: [PATCH v3 1/2] selftests/damon/_damon_sysfs.py: fix memcg_path assignment
Date: Mon,  1 Jun 2026 15:44:08 +0800
Message-ID: <A374E0020B17741D+20260601074408.204630-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601073635.200015-1-niecheng1@uniontech.com>
References: <20260601073635.200015-1-niecheng1@uniontech.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Mm+Qeo/nLo9OU8/4JY1J+7N5evmzSZiP2QGUVLCfuh4NOXSf6GjmJgLF
	uBLwcTkgYOxfDrve6GETFU0p9l83bNhFhMfW0esFm9hkMYxVgR6lsi0TxRUNMaCPMNztHEq
	Y9lQ5DUsf2ijhkQ4ICkC7wavBbJ15DqtWQz5wXAYdGi6dOgoDl3naPar6+w+s17N4X+P8/R
	Dt0QLi8pKO2kYAbMx404rLVf+vL1i9y3OoEqiI20xSu0x0+qUmg/yPXv2kvUeVcN5lzCX/e
	jsYKaU0cNVCelK12dbWr5nGuHOz/JZqJCkFKAW4tVsqfFGtx5jlnMpbesngY2UeXvrd0NIK
	U3g74JFiVGPCDjkVTWMjv9375wPQWmNZaV7mBNdAnxkTWHO6DJbQ6N6r8NRvl0JmRwD1IrS
	TpPFk8OHyXaBgb1kk8cMmrq2Z1DgWkawQug+2+lHoe+wguN6QPu+mBg9wHzR51sPd54nBNq
	va+6E4laXJ9MrRsYsP6XZ/X+c5+k1hmgSGHT0wEH7Nvlj3b6Gspn3m6Z702GJruh/qkNQ1R
	gsGTj7rRQyq+OlSCqZ2T04fZePejja+CTmK+uPFtbEov300t3k0F5Odag7QEkHop9sn+OiO
	sMXj52GAHseF2q350mEz0t+dWuJmJrIRYHnIBh8Tf+lXtu3Nrtcv4EsgxS6ohsq9p9aENBx
	3oomWF6VzUEzSVWdzyReYzydHidvtn2CjhGEbIk4LhPtCw0YD+Fti6mIAgzDF7yXqD2Jm0I
	EWe9DHOmWlDPmlAC9jjbA0twbPAy7fpVatNTNQuaA73pWi7RVdV/1q1qNYUCLTVmPWAE7ok
	DZowA6La1LmCY6aWifD2vmgQOEEuJj003m1OB9umAowcp77kmjWPYgblYwLua6o1x2DPysn
	4t95klUzxJOr98oXWCi5xI4gjFLo0ETwt9CcHw5d+Kua1p8nw5Mu/sIT793SSivXXO7p73J
	9K0oQFoOPPapRoNukZ+EpRm4Qaoi890ZsznNOWnbDIng8m0XAshaQExXnEoNEZOPK8ljYKb
	Sr6xe6YjpyoOpepkRnr1JPtKet0f0EMu6jKRAOCvYUahBGYABnSaFZTFk4B55IXt3LsDXDu
	JaP0sY19GaK1iE8RZw4iCtK9jKi/koSu88zbCBwS+TUqAaPXEjiLmY=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

DamosFilter stores memcg_path for sysfs staging, but the constructor
assigns it with a trailing comma and therefore turns it into a tuple.

Fix the assignment so memcg_path is stored as the intended string.
This makes memcg filter staging and follow-up validation use the
written path correctly.

Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 8b12cc048440..43075892215e 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -271,7 +271,7 @@ class DamosFilter:
         self.type_ = type_
         self.matching = matching
         self.allow = allow
-        self.memcg_path = memcg_path,
+        self.memcg_path = memcg_path
         self.addr_start = addr_start
         self.addr_end = addr_end
         self.target_idx = target_idx
-- 
2.51.0

