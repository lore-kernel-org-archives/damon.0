Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967305;
	b=3tKr40svfPRWuqAiMAd4xnn95mHTvTBT0sAU1asE7iSXs3ghcvDHY0cQN8FDWizRjQNw
	 ErhcmaT0fRy4CU7+e9RWtKsBOXALnLfHhu9ZvH92+BsqXXkqJOd8az/JkdIpYsfH+n8Bm
	 mcDCcyfsOONJKa/MpPWGA/CxBIu0PjIvWWD6ihgFKzpyHC1zPpqsigFWLwrzNU2bMYc7J
	 bujJ8U3fslqAhZfPR3HjrCP/Bd/f0e1w7eREuYknbeQ1936YJdlQOwPN9KDAGNLQyXN9c
	 WyiAD9mfRxqHpK+kSWZJjCi3W299rxuYDN3XT+mRy3S4kMTITsoxYLMCWI1RWiCc1CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967305;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ModsJ7OTyhdOku5yOd06nJCLRPB8N1jTa1okgDkwSN4=;
	b=vPs84m7YWLJsTnhVnaVm+Sep2nU0rzHJCJLCh/ILSjLG0YBwx5tLA5KTUkA0f0BiZz9l
	 Z7Tzn6AWZ4tZkRyteriwTWKZlIhMSJbNDVCAVcAKpHayThFGHqXwlXZusx9dBIDDFw6X9
	 GIHon8Mw8bdAazkN29RwWRi01MT+weRpD+/KSETiISDv1GOJQNWdWmsorqpsweSv1u+uG
	 H62noJTmJ21PZxL0t3pehZUklRIbCKa4kNhtyu+QP+B51bRdnjpb8JDqQy4PNO34Tj0pC
	 kRaqmLddGtn/M+POAtefs1mnSDoo1VH8cYqo7vMJZVdNJSgAoUJs0wHb1sTFkJvEP2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=If4uzVok;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FD4606A31C;
	Wed, 18 Nov 2026 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=If4uzVok
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2654D1F000C4;
	Wed, 18 Nov 2026 02:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794967305;
	bh=ModsJ7OTyhdOku5yOd06nJCLRPB8N1jTa1okgDkwSN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=If4uzVokBwbpms+48xpd3nNrPBsWL0U0bZATRysvdLzjIo1qQNPjTb5hB8+Uv20dJ
	 9UfArH1ORhOGOxA5y7BS+7YgYvBAse0P7e/K7cP6lkaLZAWxBe9Ij+c0JDp14yVtTx
	 CEPEIxS9Ykc+5KMdhAcbIovwVNQjZ3BZoHoM+v6hmzoHxnfLtFd1dbjctHYjQHrV/3
	 qesBkPaVVbkSl1NzDolU0qs1FOWnXQ47mM8rULpzvck5xgY8C/xU5e1yUeZEchT3to
	 KPt2VVSSRveuEiWa3eDRTT+Ig8bdK1xQ5SKr87Nm3ugRYVX/uqMv2gqj5CmQdJ9xke
	 MqUpKJJxnNPSA==
From: SJ Park <sj@kernel.org>
To: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mattathias Pinchover <mattathias.pinchover@uber.com>
Subject: Re: [PATCH v2 5/6] Docs/admin-guide/mm/damon/usage: update for sz_ops_filter_passed_last
Date: Tue, 17 Nov 2026 18:01:37 -0800
Message-ID: <20261118020138.97260-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117-damon-sz-ops-b4-v2-5-439888fa04ac@uber.com>
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

On Tue, 17 Nov 2026 23:22:19 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Update DAMON usage document for the newly added DAMOS stat file,
> sz_ops_filter_passed_last.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
