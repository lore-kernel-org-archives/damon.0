Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889173;
	b=GIoeDDxhHtElqCeMqe8eCVzn5iLK6eyZHORcBpajMDE9zQ9MCtaHQQzaW0wyjGGTUFan
	 gUzLOrwLeW4pS+tB8vUFoT5ZkZS6JWJw5wweAZI5drmx5nlYD4ikC3i2/L5ijqv9TcXid
	 z6bvOu+4DwwkfZqZ7HXNsIOuMhkFfOcPgxi9cwSLgCP85oeXHfHKTll3PsaUlEFSDU+PA
	 IgE4aSvZ4EpvabOez8YEC0w5OBw84XirMD4dslvhzuys8k/BwwFNhGf131Jns6pHlrE7t
	 AT+bUNMVS0QGw3YtytBoqMsWuzdRkR7cy9W8Hn2o/ZIpYUhS+Q3YylkZpFscGtI+2Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N57O/pymgahy2d1f5FroPzkC5Sl+/LdrVI6cHMQuJ3Y=;
	b=5ZhprM4gcgoHh0JLKDThtJ+tTtw1jpJcoegKLdtsmDVIOnaaMB6dddwHisCiLy/sqDGa
	 XiAODJhV0TvdOwxihj7hWrkjvJVTBSbkWpTcBnW2dNx5qezkQ+XYFYLtmK3UEOM8Aygc0
	 kFT2I9tlEVcr4qc+DR2InhWAFO7+KgQA04b1eJM0WrbtB1TrJFpoxdRErgXXYeAB5ARBe
	 rL6McGQlRlOPPyYkjw1rM0/KUCU4sqNc2+ToIt/JRGwgw1OHvLuU0FIsVMG1Pe9ynNNFc
	 ChstquGLwvMGokk2Nj3ZLc/Lddi2o+RPIQ0r4YANNsYJVe93Z6fN7Iap0tj/3UTRK7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNA+j2GK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD47606A326;
	Thu,  5 Nov 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNA+j2GK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D201F00919;
	Thu,  5 Nov 2026 14:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889173;
	bh=N57O/pymgahy2d1f5FroPzkC5Sl+/LdrVI6cHMQuJ3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bNA+j2GK3N6zSE3aTGGssivmU7TfGzCfE09L4qPQVZBB5vtGOIk67ctP6G4y++eWY
	 LTxsBVSfUlACqDIWaT8wRcilvnWkUEirRKrEAwYn8at/pDKeWYF4pLf7kjlnu8ZWax
	 NhLmYReu+LrLaEaO531ZfuPe3huzx264KW/pk38XqSo/0EB2Q8CcwhgXbGUzXXiLhU
	 Pl/BpbaCINW0/NMtRpSdBazyofbkpgTtDrK3ATT+WFx/rCuoNBvKRm1BDsgLnXVmW1
	 5e6T+/ysXXWOqw8VF0Z7UsTqX4q0fHZq2+mOGEGnTnJDYJQgjFSV7Z/PLcxXWasw0g
	 9+W/S1LpukMaA==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v2 0/4] mm/damon: introduce age_ms damos core filter type
Date: Thu,  5 Nov 2026 06:32:45 -0800
Message-ID: <20261105143246.91656-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179388191315.401969.13923237674993632654.b4-reply@b4>
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

On Thu, 05 Nov 2026 23:31:53 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Wed, 04 Nov 2026 20:44:20 -0800 SJ Park wrote:
> 
> > One straightforward solution is extending the DAMOS access pattern for
> > specific deterministic time based age specification.  However, DAMOS
> > core filter is a better option.  It is playing a similar role in a more
> > flexible way.
> 
> Makes sense.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thank you for reviewing, Aveline!


Thanks,
SJ

[...]
