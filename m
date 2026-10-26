Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025432;
	b=f27kymoMxJ4AudOyos5w3/yMNI2E83TjkXEM5Gr3ucmi1vPNBMeH1ThbLWTIqHU13jT6
	 2X9i/8jhlxkFgCM7B8abcze5gM+SyAbKwNskLinqCIdnkTVWl4YiZQ4Y0msjPKRspTn+H
	 WUIfjO9de6kUOe4sW9birGk01IIPG13RKtd1a5Alo/qkTJqi0ajGPDO9JNQrQNPezk3PG
	 WFlFVTNMCYtRJZO/HPEfcQTeuyU0FbqvramIXNk6/hgE3O6khee9h/72ENt92uRBTTEpW
	 WvMvCiYgyDEMpqipMQX1lnIK+EtLwEqfgNHyOr9VF6OXJFiKnnOrJZfqhESNOOFvaVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8PHEbKOgIuYghLeVCFmg8SLPsx9HPWBRfgbGFvrH17c=;
	b=WhHolpsuE9/YV2ZmZ41Lc7ySrtXd4qiDjy2a1v7JwwtZ4DGAfOn+nFbC7Tm+M4KV1ELx
	 IVagR07xFI1FkMjLjBHmlpv6l9e7I5Zo05ula91eo54fqazle/mJj5Psiel7WscFZ0Ouv
	 CI8IQtf2dx31ikgL4Yv0fBr/Z2tIu7/GXiZyuDvztc2iS8ZuQ9h0WKoaJcjO3LIGnCA9z
	 PlEc/7wNnVZIk+4HpLLaZJmSjqpfLCS+hvSedJfKDhfEC+d3LFFwVar87fCBGbkLxojez
	 v/TaKiTV2xcjOTHNTOE3XVZCxeLuiZErC2U9MjlG0lzHdRBXmgvZwbk08lQ9m0H9syw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cevX3BAN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F9606A321;
	Mon, 26 Oct 2026 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cevX3BAN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D6D1F01828;
	Mon, 26 Oct 2026 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025432;
	bh=8PHEbKOgIuYghLeVCFmg8SLPsx9HPWBRfgbGFvrH17c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cevX3BANmffQu1qgFyv4HRuz8GW0FWfyx9uJqCXhZxAaiRMvlBOfO5dDbdqgN/HfH
	 XoRQ2EdMkdq9BScuvVuiOCS0DQ4K4Vc72eWHn+QYnoEyRZW1TKqa4szPjOZbGDCqR5
	 do8uY9SBE+0z0lI0qmghksHnTFh9WOpYEjfXxjxQD09lVNQ2p6kFaQ7cQ8SIrgYLeF
	 kI1VnfXebszpr3HB55cK4JmN1Al7Lvf4JSqWtbLE9Dht2w1XGmBgrO8/yWK10O4Y2I
	 8prW0ADDRSdd70UvO8HIhebwL7EExfseHMMMbSPyTHcJNCJ1k0K7DIFjtTb4Ibg2Lg
	 iZ4b7VA8bHnVw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] Docs/admin-guide/mm/damon/usage: fix grammar
Date: Mon, 26 Oct 2026 07:37:04 -0700
Message-ID: <20261026143705.150221-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179301327249.2.6830202812762243627.damon-docs-grammar-3@gmail.com>
References: 
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

On Mon, 26 Oct 2026 22:14:35 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Fix a handful of grammar mistakes in the usage doc, mostly
> subject-verb agreement and a missing or extra "be".  Also turn "Below
> commands applies" into "The commands below apply", which I think reads
> better.  Rewrap where the lines got too long.

Looks good and correct to me.

> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
