Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880988;
	b=G8qyZNIdLnhaJKZ4VHAHhHwyJezSfn33MPQ6+LvvvSzhpGA3s7o4v39uY4ekNTKKvJv1
	 6YCnpAXKD+NdpePZhW2jgPzP2eiyAgZlgYnivVDYsCxEY7r0uDHhhQHOsXscswa7LNFuK
	 riMMErIjV2DMScX1qybNQCA0rr//ErUhcsKdu2zoh5XwDwmj25Elxq/CU80Y6T51eSrg8
	 Jz0ZGaA9mzpEqsCANrnVGiEGiqO9YtZ1QPHjRpJVKjMLL3wSdX5ipAigSBVSN5wWKSlD9
	 pCaDCHpf0RMmrI+t7T78XHck7xE3m6khemOtXIEmgUGMOWYFwDFvu/Ad/IEy8zjOKFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xk4s00lH1jP8Kym1YXaLQ7Wf0LEh2ORBX1GhbZk7f6s=;
	b=omZ/TlGkjN/JK9NKjyKBvCagQFcUt8TFysgLwBrdr1idzxBlUsRRkteh9wsJucXYTaHE
	 8KJdmZ7ybHoZQx9Cc5zjPVR1GlUGK7cgb69cmp1ftpWvTv707+d553Wg+dvXNRf6cD0/K
	 aQ6YtBFKFg6ab00OltPrRY6NC17mGfel/Z5nGesRsyhUPTh5Ou9WjGiKfl4yxXKzIEQUT
	 QIcmvaLWbl/9dtxBX9Ww5I6zIqhV4O7PjT4AjlFchm7gFy8L6q18gbyIWXfHBoVn8JbKp
	 oWoXdjlXT3XqhIlVGwLpFxIbubPowscMMOIXiaXdgm9PCeWKtbbqJwFHMExXc2PFFQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrwJiClt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE38606A31C;
	Tue, 17 Nov 2026 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrwJiClt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF621F000C8;
	Tue, 17 Nov 2026 02:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794880988;
	bh=Xk4s00lH1jP8Kym1YXaLQ7Wf0LEh2ORBX1GhbZk7f6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hrwJiClto+C48EC49n/1H+Cjq63wAPZR54SZhU2EAPoOznhGsCcLABIaJWwDaJbw6
	 rfN8nr7hASd96R0hpYkrxOSruU11D/asS2RZYm27yucpVPGnrqDCA5cgjVZU/nW1mW
	 Ln45+zLNkAjf59tt4NtJhM11f2uAt/96RnwjFz4kiqDAGSzzp4ac6X72ofkiJ1yMBQ
	 j/NLU9aJTIhW4ayxlU1IfkIPaIe+KOp6jom6cXnqtTTIpcmMaqIxLnzSM5wLjbUiBw
	 KL5dH8sv+n9Iuu9OzitAAlg3DQf5bIpi7NjAN3evObsWIZS2bky+RYSCYwzjJ0ftMj
	 m/gPZJYqROqiA==
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
Subject: Re: [PATCH 1/6] mm/damon/core: introduce sz_ops_filter_passed_last stat
Date: Mon, 16 Nov 2026 18:03:00 -0800
Message-ID: <20261117020301.109715-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116-damon-sz-ops-b4-v1-1-1cffe7227e6d@uber.com>
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

On Mon, 16 Nov 2026 19:10:04 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> DAMOS stat sz_ops_filter_passed shows the total bytes that passed
> operations layer-handled DAMOS filters, accumulated from the beginning of
> the scheme's execution.  Users who want the amount for only the latest
> apply interval, e.g., the size of a workload's anonymous memory that is
> cold as of now, need to keep the previous values in user space and
> compute the difference with the help of nr_snapshots.  Because
> nr_snapshots is increased once per target per apply interval, the
> computation is complicated and error-prone, especially for contexts
> having multiple targets.
> 
> Introduce a new DAMOS stat, sz_ops_filter_passed_last.  It is
> updated at the end of each apply interval of the scheme with the amount
> of sz_ops_filter_passed increase in the interval.

Looks good to me.

> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
