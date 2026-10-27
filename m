Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127776;
	b=Tbob1Gf8377i/HvuaQsaIpSaUvyu23yKWRHP48gdZYavEHMpTOEI7UcViB5UQ38076V/
	 5OEL+1hKLVt1meuO/iF1gix5eJ4I5kbkxMPq5LejcLK2jN1sxiFPLP0HrkNNwFPJjDxHx
	 ysels0BmY93S5a40uipCmELamHXU3bOmcXbhP4NM4V6B05x2Vpkl9qK5o7Qip+6IUo6C+
	 YwphQwm8sz+VYLqXtq7ip5jo84ixOuHDAV3m95oAeBM5MPoly+k0FnS4DQVVHSNMTnByz
	 3AF+emDQcz6GplD4pd5cFukLL7d1gme9kTTvLHF0JHoKLGkwwZoBsgecdfaLdfnf5sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127776;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=1jtA5ybr8vFxqljpK300PDPycf6HryqQqX763TrmniE=;
	b=p9c5tRvATRR5a6JwFo78Vydymfz4dP+MGkm+HLRckwhb6AWlB2EtROLDA+l2ZWmT5sg4
	 kj5Ho9cWT9z6EfqTuMC6dTxn7PuXxe3PCKMW3v1pSW4YJKAYaQ9LylmzO/PDZz+WVdwO3
	 u8hSuN2zC3ptfh21NHdGrbsghKvkfe/38MdmUUYvwWtRAvIKVmb6A1CEVVSjBxsQ6a3Al
	 RTZzaDD4aWrVAfZR5Ij9/iSepa6ZB3xf3Fvm8qCrTOWAhkuuJ5jizJ8otqjVMSXGuxMLv
	 UJnHgFoazuADcDJsyNiHf2auBXPes3nKD4ZBAl9wwCrZNmayMsdfm+vx1FiSNcpWrCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Nt6KpMmo;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B83606A31D
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 19:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34B83606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Nt6KpMmo
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jDfyM4cmKzMkr0;
	Tue, 27 Oct 2026 20:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793127771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1jtA5ybr8vFxqljpK300PDPycf6HryqQqX763TrmniE=;
	b=Nt6KpMmot4zqA3t1yOECOI7SB5/sV4SAONLx758SqvyYG61B9XsZnK2eSKuGsLhy+ApIYv
	Hy7cx4hqmrpLgYGBbE42Z7dwIKm8p/WfGnB4a3RpTbKw1YYJsAyrTyJ0LKJtPjkt2Di0Jh
	bYoFDMWTVY2bSe842g+3YLukT8NxZlSAVcwAUBCAlI/Mx3eei5+KOLu71s4bZrejr+I8yr
	DNPyJQn8luYhVsbyLsKRYaLVqfQfQRG/ufMmPjzWYgcxJmPpn0kR5sxHrxsCBH/cnqGZbA
	kWn6Kshk1uZddkRl4+G6zrdjQwqDu9PHuZcyACSj+h2N0pnQbYt4dBUUYhf9og==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Aveline Noir <jm5905938@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Docs/admin-guide/mm/damon/reclaim: improve language 
Date: Tue, 27 Oct 2026 19:59:38 +0100
Message-ID: <20261027185938.2526259-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
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
X-MBO-RS-ID: 165968dc3b9658f2d5e
X-MBO-RS-META: ekir4kjfqi65edx5rn14zxbd1xffynbs

I went through the mails and divided the diffs and suggestions into
two patches. That's why some changes of [PATCH 1] get deleted or
written over in [PATCH 2].

I keept lines with barely over 80 chars and didn't fix wrong upper-case
in headings. I prefer uppercase Nouns(sic).

@SJ
I hope I got everything. If you have the urge to change or add anything
feel free to do so.

[v2]
 Include suggestions from SJ and Aveline
 Split [v1] into
  [1/2 v2] Docs/admin-guide/mm/damon/reclaim: improve grammar and style
  [2/2 v2] Docs/admin-guide/mm/damon/reclaim: rewrite complex parts
 Fixed an upper case and a missing double space -> [1/2 v2]

[v1]
 https://lore.kernel.org/all/20261015080623.808458-2-manuelebnerli@mailbox.org/
