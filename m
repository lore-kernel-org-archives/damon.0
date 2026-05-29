Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E22DEA89
	for <damon@lists.linux.dev>; Fri, 29 May 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780025309; cv=none; b=RRIHREq57A/jMLakA8hM1aAH3qARJ6yRZQ96ESFvyf8cLEK3B76YXwYW5Xna7+D3TpOFrcb194GE+w9C0oZdIJyCnaV/WJMBIh49mHS3pWPKfwfoNFTxnTAAkSXamPiKRBh/7lIdt+lDmSeP/rmDWc0bb5vExV1lHnaVaJiC5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780025309; c=relaxed/simple;
	bh=8IwdZBEOJI2Wcts5o2gq4JYgAraGcS8hh110z10xhLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tamwuSJenfNGoYkjKOd9gga3ot6/8Xff0FYeSKHhnrUbChM+eDXRsd8eYPFfSeFNLuFJBpKLz/HubiymEcO7aVib9Zsx3L7u+9orKziHp7htVgnLmH2fKGFjG8P7p3j339bgGXGt4be4K78HlSouvfJTKEeaBJ2Zk+I8rxWNhKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Qdh394vT; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Qdh394vT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780025268;
	bh=h6PEc5psigEz/kH0bVSk2Y2gyiMDJw494/MMiO7Z36M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Qdh394vT/vI/ySlc5OYI2nLiVE1WQ4H0HGAeJAj3ReyLOIw7R3pSyvs3GxuUR4jOg
	 YdBJk+4sCv9Jxf+k601Y3qNq2443wn0oW4CX2J22tHNnLYUvwN+2KzKB7222erR5Vl
	 82IOLEedAghxebDHOB+aq0NNbtuQc6kO3+iJL/Vc=
X-QQ-mid: zesmtpgz9t1780025257ta18e5e23
X-QQ-Originating-IP: i22l7cR4uab6Epn6Jsxfji0CDWCVfMPMotNMblrXw6c=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 11:27:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8449337721891734476
EX-QQ-RecipientCnt: 8
From: Cheng Nie <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	kernel@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	niecheng1@uniontech.com,
	shuah@kernel.org
Subject: Re: [PATCH 2/2] selftests/damon: validate memcg filter sysfs readback
Date: Fri, 29 May 2026 11:27:35 +0800
Message-ID: <AEAE007AE486E7ED+20260529032735.1564733-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528142819.153573-1-sj@kernel.org>
References: <20260528142819.153573-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NJC1vxR0K3U+co+ZB9/PBPXOqB4jNN5WenhxLVWhlk+8QM68mOyHqYM4
	j9MeKvnbki5bkipvzhr5vfdwcHYQ4c2KnfWYl+jyJke0QeiY//HjP0XAF1nC70eqDzLuk+D
	62xQVBwTMwGNhZDxIwNnz8Pny3s4B4ZMUZgo/5LR5JtkOHzCrVczb3UodQbVmW+JVYN7zNb
	HDG/wW4m66EuXrW9S+ZNGvzOqhsuRGIjcCOZn5l6iAjpKNv2BzujN/IKnxQYyyM9pUzST5G
	JSYtZjufe14avYO6YyR3MQqB1OMkJ27A68thlbB+Rl30q9kbKSAYN5Zkb7Pg644ZwHmyMzy
	gfHpeZV7wSVp5e2+KlxR2CTlh+SSIbpCjHb2m5dC3kWKQOlh0WYD3zuDX4V6TNJigPUP2/p
	fAfaZn4R0FVwsTCkBfoFuuOJBjawtc3N+TU14P8+SoRpWqkJf0ZQavEUNKVVrD78avrUAz6
	r1Xcw4TVbr648szQAZvq9dEn0cHIrFiTkWFhetiIb2DBQL9/c5JY/Yaj5pNbolJPFiLqvoA
	qfqnkjq4K5JXNNi6MdAY8RPMr9YkwIG/ppNHe8jUbIA2fFRcyVqNNmcxmPBugZoOplhfKt8
	tKk/Lxinsn5b9lcBJYUQELzRf7S01SM9lmp8NodEEeSOSjTaDjJ9c7BDaI962BB08suzupd
	L4vnG2oLgiLO5gm1szyS5dIhMQyS5u6h9zI3cR0brFG0XV/LsoV/XLYlDpz8bJAa59cKeME
	VVG+dyLYar/TkVnMp/gI06n/3dXBUNjgc0Jg69NoowUial6YnClhAtYyrUgzeqoaPVjEmVt
	3uw0CUasQp044hpGozP0fhFbvWqY5lCwVEeAAjWg2tGCctiGSV9NTQc4WudmxSyMzfach8d
	qImEbW0gl/CukjU5J1KjBAOrgaB4nDSR8wyR5ermHcqpesIfK1TA+9geiUwEj8Ox/1J955a
	WQ9uwGolkr1R3bEEaJU2g6TRthcN5IWBufyOEJByuxUdujsZd6y+BiYZvWfjNwsAnSNc3OZ
	TzkZmnK0yR/TJLq6ZLCJDuQglRv/2pRi89oQBbgdhLjRIGcIZiifxzucP/ARkf+ae4BC2Ht
	MwsqptsSty/gDOTTyUdEaCTmA+jKJuiSIa4YkEOvcWXeYNQ7WhLePM=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On Thu, 28 May 2026 07:28:18 -0700 SeongJae Park wrote:

> Could we use 'selftests/damn/sysfs.py:' as the prefix of the subject?
> That will make it consistent with other commits and let us easily know
> to what test this change is made.

Will do in v2.

> But this is in the middle of assert_filter_committed().  As the name
> says, this is for validating if the user inputs are passed to DAMON
> internal.  I think this is not the right place to test its 'staging'
> functionality.

Will do.  I will remove the memcg_path readback check from
assert_filter_committed() in v2.

> What about adding another test case at the end of the main() function
> for the validation of memcg string staging functionality?

Will do.  I will add a dedicated test case at the end of main() in v2.

Thanks,
Cheng Nie
