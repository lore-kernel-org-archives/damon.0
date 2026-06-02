Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6A2C234A;
	Tue,  2 Jun 2026 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363745; cv=none; b=njoerrf4i96BhVFpPrsiX9rdRsrTQjWGt0DjoTLdbkC30QnVvangiNxnuhyN0/xT7IWyAcOCqu8TPwbftBid7Brr/IzIozY8bPZfLaJABjLgQMOZV34LKKiZhPgix3lLU6IRHEk3U9rkm+WUrIl9sRTpKS/01MRJMHb6W1xAdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363745; c=relaxed/simple;
	bh=yNhsL6+11YWE0+t3tPnoC8/7OltlZJGmj23wQr1wC34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xnq/M2Uk/3nayqnDuZ1GYo2T6NfqDjP/TmDV83MyZ0KvPwXwPwzYPN8/U4T+ipykQLwjcLSj6jH/I5wIVbFxQmLy+rnYwZVR92swDe5Q6x3sPRtlv4SE6oa6Ueu8QdEi14k1IRVeMjiypW3XHADmbviW71XSoFoteRdZrkO/CMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZDbP/qRg; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZDbP/qRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780363724;
	bh=M4xn0QTwhl2jCk5EJX13+ffTRXm7Y+KXJJFxxf4QpJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZDbP/qRgz/phjYTArEzQCWVIPZKJydDm3i6+x0CwMt0pmc2wYVIGX1pFXKivv6u2M
	 7J+ifYNQ3N7ELg5z5Iv4utoufstzZwIPT77dhshEXUWgNC9HBQUmwrarwHtHM7VZ+d
	 Pm5ztXXQeU2Yce46Baacg6+m3epYAY8Rn2lR7Pso=
X-QQ-mid: esmtpsz21t1780363717t7d3e3f97
X-QQ-Originating-IP: WhF+Z/FeaIYUrJYqIzDOxcXbCfmg43NAxv/Wr7vjIhU=
Received: from PEN1097 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Jun 2026 09:28:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13331546314602505893
EX-QQ-RecipientCnt: 5
From: Cheng Nie <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	niecheng1@uniontech.com,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Tue,  2 Jun 2026 09:28:32 +0800
Message-ID: <A556945AF3D53065+20260602012832.30023-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601143338.111762-1-sj@kernel.org>
References: <20260601143338.111762-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Nty3yXuijLhXh0QhXJ9n15Ck6jLB8qgSw/c9+hKuBQhNrY9Fuz43tZ/c
	9H7P1zCaly99REt6hDz8gIXApnlxQdzgwIrmrjVTsMfN2vHxBxY+8ta9KI5vaQ4/ZIP1sAF
	n7jDYC7vM4jXcb9c0YpGOfWNScoS2l7S0l8sUu61w9NJuDFstsrtUQhyPo6UeNjzQIjGdOB
	euBO854frFVd4yTkzhbJNM+Y3iZtBKK4Axp+nlvntF7Kd8OVgkhJsQFjxHW8CUI2iU/oZVV
	YUprIjeH4in1KBLtwMfcNPNijhgslG1YsHRNXHZ7OxrWs97LHPt3KmvpMAKV+3ifTNezO+V
	hAPWrChV2eNWpDNGEBfbEv22PWlILsv8YGONS+1vC59YvhsnIc3QMc+VSUxmMZ0aIM+YpHi
	gRNJcPA0Dd71vsDiNEshCyth0mCskjlpEUlZBGCE8eKrX6rxoSOOeCUAyiySkLVW+1tiH25
	2HhzkWa/NqDwerbnqLZv6grm/NJiYjtbv5GyVydXmnQMKVHk4asrQrJPiC6yuYXmzy4vRzl
	pzf5vTAz63b+oNzH5bQzxqcxCMOetsw/fWKvQ1JYyRuyn1yQ/qdDEgvqqEh9vg2ADq7/yDJ
	KZD2b2PDr5eSby+wWRQ4XOVSTy5pJlwta+u/cPU8meX1lpw/c0PCQVpujg4lr+E+/mbQ/1S
	FZSYgjQBeRuRtleGtBz4Fho7Va8tKB7l3gA94Q25a8MkwhRx0ssba4Czq/YUMVlBpdEHEU5
	+km81Cpk2NWN4JsipOrWyUzTZOzQJaUxybtXhsIf18mZjDVbkULuSYYkHWZ5XWb4BZ90GnR
	KNevWw7YJjkSQymoMKXzjdcYHMRZkuxVSLu9F/Rq5EEtuVhITnyg1+1aKbB2TlG/2IeVrzy
	ydoIdVnN4Di8n3Qn1Sg5epJVMd/KalKBu8rtISXkcAjzuA0CK4cfHG9+ChFNfDx4zDzFEXf
	6JBgf0/aNgAcawK/rABvTsjZ1P3irGW72MSQbFdqOFg2qLmyAu8NHSkSO7GMRg086IgdJn6
	AYWEa/96vEB2nzXZKxiWSEZtDGVX4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Hi SJ,

Thank you for the reminder.  Sorry for sending v4 too quickly; I will
wait for reviewers before posting a new version next time.

Thanks,
Cheng Nie
