Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026772;
	b=wgP6GrgOq0gEOqM1fV0ggo+krUB4FnI4LVacbH7XG5akp8wTnM0PzBvCepblKJiOTD6y
	 9+e0oaE/lTHzEYYcDixwwDYcfxm9ymcspd+M0czKIxD2Qqe7qidnJV71qVnvuuScCMj56
	 cMlGfL92Er6wjM80FeFT1akOoCDHZE9ebYXx08B/+ddldpkkZmjAb525WbNTU7TPu0l6C
	 nsYo/t5Uu+yIfh8X0E7fsN5/efSNGBWP4w7j6k1oOOKi9jzxHK1uiLNWvG88EEUWzLOli
	 Qu/pXTSWDopltwHrKYo0c0CqWgQtXpqBntcYUGmUwAX8tDu/WuXw5Al0ZnGPN2J//0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026772;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5XGT9zayb74NMaQfkHtdMf2rxcAZC1OQzMLQh8262C4=;
	b=keJ3mDXqY7EiaZHTDdG57WyQmXQtOut2ujXWqfFLNkVxO5mPYSYxN4cOFDaOpKlXlE3m
	 IQ5aagQOX2B/La8B/7Y8osuDq0RS9J/JYYJIXL3Og2eylu4xthVoEOH5YAoT971kb8ZNr
	 lwNOlKZi/8Fdw/7MPQf7jj6M1eIEJAfAAUal01KyasLqWOB+isSuNvcFyx/TolNOrmuo/
	 tqoQtLLkRBSBPbMEBpWijPZ/daO10hbWgYC6FwjbWgoXTL6HFk/EEcnDFC0aOaUpUQG1T
	 IIsdUsoO0371SUkM7WZqHWVLATOrEpdGqBHVrdSQKohg5K0rUxKeJxq1TLHal4L5TFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5+lXO5E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1D606A31A;
	Mon, 26 Oct 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5+lXO5E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E98A1F01825;
	Mon, 26 Oct 2026 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793026771;
	bh=5XGT9zayb74NMaQfkHtdMf2rxcAZC1OQzMLQh8262C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5+lXO5EpTR35gK7UDBt9Dr29o4Ac65z6kAbDynbPJdj5oe3/UV8IoH5cEByDCTrj
	 z8MQbpxrHEdtfP7wfQD2bdG1cppB70hJUeakAyZaKls7m1GYc0oQd9kowzyyXa6gkL
	 OyL9qwY2NeZiAu2oaD89cJd2RkAlSMN+0IvS6YlIFAhjx8m0Mb/tSMgcJfu4cNDyn0
	 kjTt2cR90jqwR544omfMrplkKXjARr63p5+556Epuk2l8DLXBII349bxY5QL/ToIkD
	 YzNqD9y0KUirtbu6yabSHcwAO7Qu2q/2LOt196AGS714jv02m3PqUfdPC7waeVt5fq
	 ZF4W5YqQZOISQ==
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
Subject: Re: [PATCH 8/8] Docs/mm/damon/monitoring_intervals_tuning_example: fix grammar and typos
Date: Mon, 26 Oct 2026 07:59:23 -0700
Message-ID: <20261026145924.151190-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179301327249.2.2968995103662294177.damon-docs-grammar-8@gmail.com>
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

On Mon, 26 Oct 2026 22:14:40 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Fix a few typos, including "Moniting" in the title, and some grammar in
> the interval tuning example.
> 
> "starts looking degrading" should be "start looking degraded for", as I
> think the sentence means the cold region detection starts to look worse.
> Rewrap where the lines got too long.
> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
