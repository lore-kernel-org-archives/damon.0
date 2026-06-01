Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ABA5733E
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275300; cv=none; b=i3z8kw0+i8W3E39eps7VC4YGGnmdV3u9VHP/7PQN+YmCLqWFI6b3IWwZYCaIu3IjdxhReYyhMYATFJ+/0WpGB03MhRq6Mlia7wdY5ADYXvB9VuUMAC5igoFQBFHq/JwxX/c8vobN5u1jfgKkEkif6U5lx1kCST7S4QG4mgegIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275300; c=relaxed/simple;
	bh=IEJJEqNCkLJW/qCul0Gskb/AUCzPBTL3PE8VRk1n02g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+rb4CxaGhyJTgoHW3YToY5IJyL+A4iUawxNzlNI5jcU7htRxP6Bqtls2vkfOoa6Hc2B8H4tD/3Ib11FVqu2Jjh4Jva38jd6lZEkj9Q/B7O/G+SKUSjw5FZ9gPV2soRmFq4owTKMH9efehJw71VeWJSGWj6NLTWA04ST5u30m9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZdLvSXr6; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZdLvSXr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780275256;
	bh=wplUvBwwSZUkE/1pF8JoDJVBT5NIk5fxpFOgyy27ARw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZdLvSXr6IN0sOxjm16/fc4DJSCHCiT69okgiqQhMfJUTxQbrF3i3et/IO36XyF6TH
	 0ra8LkjUZnqDJSsCzy0ySqO9F7g5jKbCXIFRcBNXnwLi4gvDUDsZ1BeyjLfbkobD4y
	 cLJnr0azS3cO1UT6o77oR2P2BTgTPR3qDgre34As=
X-QQ-mid: zesmtpip2t1780275245t0423d3d2
X-QQ-Originating-IP: UErp3taaIoj7K2ov1DmKucmDovlP8o3qkbRO6SlocXQ=
Received: from PEN1097 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 08:54:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14429530627096407333
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
Subject: Re: [PATCH v2 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Mon,  1 Jun 2026 08:53:59 +0800
Message-ID: <4378862A53A443AF+20260601005359.26544-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260529150057.84753-1-sj@kernel.org>
References: <20260529150057.84753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MwJMCv7IGsyW0OMjaOMs13To4Fl6JKOmG69lSHdjIrVjZBU1BVNdCRZG
	sv1ixIIM65x/dClUwvTMWttdwXpoollDXnXDNtePtQ+n5jBkKW5Vv/z9wPmJeiwRO78nKW1
	MH/QPBut+g9cueTOns4G6b2S8hNXYaDlWs6HkqFBRLuOpFl7AXf93qpFe5dgsMBUb8WjWCz
	2XjYUIk0uQow3r0a8EilOKyvMVRRT7qAFwj9ne5I5BZcuttflgifDeHcM5quBuLLFgXWQSy
	0AecNgp4etO9fcmSujBc4K3lL8AWylvIGeM6kl30IXvL49Tu7tdmI1OU+/EFfPUzzcl4bYZ
	hqEMjrbdJyCOnrKY4KTXgtIK+ha4acTl6CDAi0RdPImrBflCiAJaNoUDSncKJKKcW1OcH38
	1kYWzE6L5ca3Tz74cw2cOxPSJcOKaWnw+SDC9kW192kmxKBTQQMHxQIn8OVUCIOwC66gmSm
	Sa58QUHMXPu6weva50gf3xTAyg6k8EGBpJwx7UwgnbyGKeMgyFAY6mHZx5iM+7AG+PWLN7w
	MQFgTjvS0R3002E285i9bvPG5t9qFfpclsrs6GtD2LbMssZrWQtL2cdKxwMn9S9jKPVOXw4
	o/+Cop0daXds69HneOta4BDAafLpHV1lKiAE95Y0czCzWG+smyUD6+RG8jxFX5o1c4I/ZmT
	M55JSi6t3ggZxYwHoszkZO5kom7zqOrBqHMwq6Nc3yFobJbon/FPVz4YHIVSSH3sumFVl++
	fJppNDnZ5oL5iispPGPDmhQq/MuPdgPdl6PclEkC2BIXmRZcjwa/5ZWFUcmuxCfdBFr4CYu
	DdpSrUdCUayxnnsBTcVQ3Cz5C5IaezzEIXciJSFzOxL7p4s0jMDXpqHvlCzccj9KkYMxgnK
	i/94buMvUrdugPkTMU1DmEmt6yUwxW6+9nDGkbH6MtVVi6BAl/wjO0bUWCuVsB04wylcpof
	syvVkWDgme93LUS7j4Q3XSTyfvCto2uTsH89Ul1xxgLbO1jvm+o6xijFx3FTVCbfdIUhCwI
	t+XPKmld3FjgfF4GHl0mT6Lepg+YaFcdzLsdEZIuZfyju3+Le6MvIlYAsu9L8=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Fri, 29 May 2026 08:00:56 -0700 SeongJae Park wrote:

> I'd prefer the error message to be in form of something like "'memcg_path
> staging: kdamond start (%s)' % err" for consistency.

Will do.

> It seems we don't really need to do commit().  As Sashiko mentioned [1], it
> also depends on CONFIG_MEMCG and active cgroup configuration.   It would be
> suffice to simply 'stage'.  We don't have stage() method on Kdamonds, though.
> What about setting all parameters including the memcg filter at the beginning,
> do 'kdamonds.start()', but ignore the failure, and check the content of the
> memcg_path file?

Agreed, thanks for the suggestion.  I will drop commit() and configure the
memcg filter up front, then verify memcg_path readback after staging via
start() as you suggested.

I will send a follow-up patch with these changes.

Thanks,
Cheng Nie
