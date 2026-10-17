Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623D392C27
	for <damon@lists.linux.dev>; Sat, 17 Oct 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792251182; cv=none; b=fY1ii6NzmPLMT8eueUSjvcH2F2oYUKy1vZWjNf7D8apioZoLiaCyHmhrcQkCnvqw02lJpv9lgNzh8kS2sbfC2aT8kINnzSFUlt9nSs+hfId5odwyvDycAayNJ6LozbmKopDUATG7dpELD5Nh8FoY2+mVCuF8hMcl0aIvBtCGRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792251182; c=relaxed/simple;
	bh=awm/5T3OP8nOySmaCCffHZ2HNGXR56c+zXIdHAAIc7o=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=RieBkW3BBd2RmtACdzyQ8+x82160+2Rex3hek99lTNr9KrEPZ8+rPRbaLay/2ci1raxzt8293zuwHEvJbi6bmt29e/Csr7qxmATCPNk5dvmOR0ss3O1GQ3aUVtkuEXyFxf3ZL9JIc8OYKdsQezB6XadKTgM8KbQ3GD6tbaVSBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i+vP8gz/; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i+vP8gz/"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6Qmg4SVdzKmwd;
	Sat, 17 Oct 2026 17:32:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792251171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=awm/5T3OP8nOySmaCCffHZ2HNGXR56c+zXIdHAAIc7o=;
	b=i+vP8gz/PgzUMFCTE97ScuteN1psg6DccE5r+va7MmD0Nlx01PCH3SHzKQlFjfs9hMkE5k
	EABtAgU22fv3uacWuuyTANWTDzGF2QrNnOiysHqAzlx+njp4+LNwPWs/xyS/Mf0ntZHDQp
	IzXaaw4Tg3QOmfAqOD8ZayjGzzuabgBnnNW5JEXdh8GdlmcTAW3QqSVgcLQsY3dmMUK4GP
	Jv6vFHx2gSJyginlU7cC8azrv5TNZeQn6h9b6jymJH0FVbpCEDOPhLP8w2OFWPVgaN2nj0
	t/8uW6LCaoXbW1n9qyyHLZa1LQZc4nWbTWkiahoFpt84hU5HSS2pQ2Njto+Z1g==
Message-ID: <1061edcf257c9e625efe5f6f000013e9b2d4c650.camel@mailbox.org>
Subject: [Duplicate Text] in mm/damon/ and Doc/admin-guide/mm/damon/
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>, damon@lists.linux.dev
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Randy Dunlap <rdunlap@infradead.org>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aveline Noir <jm5905938@gmail.com>, "Adrian
 Huang (Lenovo)" <adrianhuang0701@gmail.com>
Date: Sat, 17 Oct 2026 17:32:47 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-ID: f1c05a7b6cbdf6f28a8
X-MBO-RS-META: 5enp6ifq9dbwkjns356ocpn3tbqsbwnj

Hi SJ,

there is a lot of duplicated text in these directories. Diff doesn't show
any because in mm/damon/ the text is a multi-line comment.

~40 Lines in lru_sort.c and lru_sort.rst,
~50 Lines in reclaim.c and reclaim.rst and
a few Lines in stat.c and stat.rst.

I think it's important to decide on how to handle the duplication before
patching.

Delete one set, keep (and fix) both or add a reference in one place to
the other? Could sphinx do the duplication?

Thanks
 Manuel=20
