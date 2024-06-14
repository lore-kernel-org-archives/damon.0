Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E21862B6
	for <damon@lists.linux.dev>; Fri, 14 Jun 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334030; cv=none; b=M4FtX1ebDpUj5zn2pKSiUZ1FbBemHaBB7vB2HtSBRRPR75vlQWmb+w2BoefwIuDaePQ6EHLg+k7dacOSDfEeFESk1IK8NHCbtipqVvZbxR0HXvpPbOa/uNkY0Z/8iXpbK17y3K5pPn6WamB902G/G9mZDcRTGKQwLLv0HI2sWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334030; c=relaxed/simple;
	bh=c2VM23Et//rTo7WvAQZoEXKmrE9QyrPIRFHO75KuJoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpVTdVQzjYjxtPTr3tMLfFJXlIexBxCcuN4YXPUpLMdnoS35zhpe/s02+YVhG+7fvFDegW4lr8JDok0f2DqTYD7Hx8ooa5XOOm9ZdkxJVoxeStJMPuQ6AMnCsyuPT/hlhfYn7I7KEZpjachKEMpySPahgf1RhVzTbT6exmRkWCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-59-666bb2482600
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v6 7/7] Docs/damon: document damos_migrate_{hot,cold}
Date: Fri, 14 Jun 2024 12:00:09 +0900
Message-ID: <20240614030010.751-8-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240614030010.751-1-honggyu.kim@sk.com>
References: <20240614030010.751-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnka7Hpuw0g/PbhC0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6Mrh89zAUH+CpW9TezNTDO5uli5OCQEDCRODClqIuRE8y89PkYE4jNJqAmceXl
	JCaQEhEBK4lpO2K7GLk4mAU2MEtMOvcCrEZYwFViy6H7jCA2i4CqxI+1fWBxXgFTif9T+tkh
	ZmpKPN7+E8zmFDCTmH7sHliNEFDNhStboeoFJU7OfMICYjMLyEs0b53NDNH7mE1i83p3CFtS
	4uCKGywTGPlnIWmZhaRlASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzACFhW+yd6B+OnC8GH
	GAU4GJV4eD2eZaUJsSaWFVfmHmKU4GBWEuGdtRAoxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfo
	W3mKkEB6YklqdmpqQWoRTJaJg1OqgVG27zOnZi6j6OMpxbu5O57Zh22+LK3CcdKk1uqCvf0m
	HWe3qZL7uoPmrUgOYYh/kfdn3u0Vkl/NjnL6r3E7tfXnlR0WQh9LvD9c97p5/vSBq7NyZrx6
	5Tu5NWHXIq9NjRk80cXsqSt49GubWsQVI+Ze1dV/MuHt69+H5jPaZBxnuduiG6uQMFWJpTgj
	0VCLuag4EQBn1JaJfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNLT9djU3aawac9HBYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDK6fvQwFxzgq1jV38zWwDibp4uRk0NCwETi
	0udjTCA2m4CaxJWXk4BsDg4RASuJaTtiuxi5OJgFNjBLTDr3AqxGWMBVYsuh+4wgNouAqsSP
	tX1gcV4BU4n/U/rZIWZqSjze/hPM5hQwk5h+7B5YjRBQzYUrW6HqBSVOznzCAmIzC8hLNG+d
	zTyBkWcWktQsJKkFjEyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAoN8We2fiTsYv1x2P8Qo
	wMGoxMPr8SwrTYg1say4MvcQowQHs5II76yFQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGp
	CUIC6YklqdmpqQWpRTBZJg5OqQbG/kSbHx8jjipynP52261/4XaTl1Wh/omTsr7u+Fma9oL/
	vNydvJqm3ymFAXVHjn5q2BP+aQJ7iNCLtx/FJl1+Kc83KXr1Q7NIz2rTPdqZP5rNG/wLTy4+
	lrEjh39TR6fsg+tnrnXenud5rGrRt00aHgp9UW7qoY9aoqfOCOp7tXDCWZf4iF1HlFiKMxIN
	tZiLihMBFQfDUG4CAAA=
X-CFilter-Loop: Reflected

This patch adds damon description for "migrate_hot" and "migrate_cold"
actions for both usage and design documents as long as a new
"target_nid" knob to set the migration target node.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 ++++
 Documentation/mm/damon/design.rst            | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index e58ceb89ea2a..98804e34448b 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -300,6 +300,10 @@ from the file and their meaning are same to those of the list on
 The ``apply_interval_us`` file is for setting and getting the scheme's
 :ref:`apply_interval <damon_design_damos>` in microseconds.
 
+The ``target_nid`` file is for setting the migration target node, which is
+only meaningful when the ``action`` is either ``migrate_hot`` or
+``migrate_cold``.
+
 .. _sysfs_access_pattern:
 
 schemes/<N>/access_pattern/
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 3df387249937..3f12c884eb3a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -325,6 +325,10 @@ that supports each action are as below.
    Supported by ``paddr`` operations set.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
+ - ``migrate_hot``: Migrate the regions prioritizing warmer regions.
+   Supported by ``paddr`` operations set.
+ - ``migrate_cold``: Migrate the regions prioritizing colder regions.
+   Supported by ``paddr`` operations set.
  - ``stat``: Do nothing but count the statistics.
    Supported by all operations sets.
 
-- 
2.34.1

