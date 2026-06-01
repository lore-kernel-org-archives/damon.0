Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F093612EE;
	Mon,  1 Jun 2026 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303637; cv=none; b=XBgH7Kra3kPqOdod9RIdEODbPZ9unxBkboFQlyQpZQrQgsNyG0izx8m+TctaKclufkPPBIlPhRQQIbR65BFTnvmFt+zmNOu7z0aCyk1AKiRGWuTfChVTdw6l4gtRDP+v89qDzb+ttT1Qj7RZ3eW2KoV4qvcWchpJAU8t8YHgSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303637; c=relaxed/simple;
	bh=vX5BfsPa5A68VVnS8RnhmW+u//JcdoVKLcTeGf3fT9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkbSaD7c27MIaOfGcU4gTCTyy/8EoxABjgz2EYONwosPNoc8ZA+W+r3eklqWyGupoUFN7HD9WeTP5RyXZ+920g42ZcmYG6lYHaIuWWSshZtKaipdFAFBCOGf46NuIZY1iP6+naYL7bZEAE9bgPSve4d3Gv8QL1g9jpYyMMkTkSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cBJgcPeE; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cBJgcPeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780303607;
	bh=lm7cKJpeJcGZ7rnE23IAbIn/bV3fvUzB6OuFZrA6new=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cBJgcPeEZOEAwEAzYd5tmz/1bbS2aUtYKRSxBrQh3aE37Y6Q9qhfXeVSnrGHdxPcd
	 TeF0oFhvNjS0WbHwvGkbH3fKwP5++g720UA1o0rYD4e2Bl3YI4U/TaxNrUU85kR36d
	 e4sG1QGLvQ6vgG3Zzr7kcddhn1LkVOQHpfwm11zg=
X-QQ-mid: zesmtpsz7t1780303600t4f15ad53
X-QQ-Originating-IP: Np2n+HOREzcPugsu0aN+ms3gggza1Z72h61EW+IXUJA=
Received: from PEN1097 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 16:46:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9063147369591113145
EX-QQ-RecipientCnt: 5
From: Cheng Nie <niecheng1@uniontech.com>
To: sashiko-bot@kernel.org
Cc: sj@kernel.org,
	damon@lists.linux.dev,
	niecheng1@uniontech.com,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Mon,  1 Jun 2026 16:46:35 +0800
Message-ID: <44CF9B1C840A17EB+20260601084635.234772-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601080307.0532A1F00893@smtp.kernel.org>
References: <20260601080307.0532A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NQDSFSrlZSaiOi1mUdRyqp7FVcVzrRSSZhejmmQJGuJjbhIigKoGKyAL
	xP0zTHfIol5s77++zAD1YAmXfvxV6lHUpSXoYblzyhuTvvsVZqiCDSv8AYv0JLt1Mwnq03s
	03q/pNklnqALSWxQ5LlgvsQgYWkYYwm3VkiZegqS6BxJUN5FoNB0f+zp+b/qdgC/CwOeNU4
	Oc8+8bg/gkrq6D6LBA+7AKg4/wvH6zJFR1OZAl1JLN4XUy3OTmO9NalJcxdtbqAKqkD5Mlt
	aS3i1jwnyqUM0nXoMB2YqOAAnx2JvveoCqVsrzNglEcoT9zePBg9fx+UNvc9WKYQxEbbs4v
	C49s0mfu0oGr4L6zuMTYRMBu/SFznJGfa7f8tqkaIUOjlAnoqSghQ9xI8e8mQd1X3htbUmg
	BEYdzgHNwLJDuf11YcQE4xaMjlZAa5NKoMB1hOvEgLfUtHjlaj+LKHIHPnGmp4c0/d1rJen
	/VVHUJyHrw0mwbwaaIrDryw0Mc7epcW91AZuxAM1Y+QsxJr23jxvL74y/7cit7GtRzbY0+5
	9maZSa6ZkS+ifdJmB49u8o6uQFp4xDQlx14S1qCiq/5oGFaG6nFiDdY8MNPTqAlt3t77uF2
	Af5puiFghm28vzpF7HZzjOP4woUlg1VCKvHwj65Ev5GAhs9MK91kjALPutDbLljyY+VZqc/
	427eYojeeHrn+pMXt6Khu2UQXbbdW1hRus+X0Kbp0W3tIvqvcmRxsTilsFtWMQXyHRsti3/
	+hwOFVO7e/3kvuEQdr1ZaDJkuVrWXrfS2hVTef4Q3mOEhfbcWGVC8/mDMX6LksP7R2+kvji
	sA/CRB0KYkk800Phh5oJCZoi+gQD0tpTQIPzq+yrbY+EzQt2sWAiiMYzmTTSRC1Z0duR5q3
	Sz1nrBdWjfzZX+TeSg7Daf0bQ0O40+d1DKGE4prG3W5CGfuD6vcP2GPOtBpafbFvoql/og3
	Ip1B0bFSQxssMIVtrBLxeWCYBkdI0Rto4LXQKJS2+kPySBGfyoB5nP2TzFeel0kpzEqJImy
	Bn0iBxYzmM39B5CxGQ2Wp2BgGBX4P20jPDqnohysFMQdPLu4CaDfsAV5hz1XIj5VHWPwSR9
	WAJmroyi2Ny
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Hi SJ,

Thanks to Sashiko for the feedback on patch 2/2.  I will send a v4 soon
that fixes the stop() cleanup issue in the memcg_path staging test.

Thanks,
Cheng Nie
