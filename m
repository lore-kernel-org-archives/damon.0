Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966728;
	b=jGuX88MHk/PknrnxJvnVfgnwQdCmXJzlU/PG67dv/YTtPwoZwZ8ynT00eI0yTOW15qFo
	 6oG+rOUyhsl2R9Dlq9GQvHb7h/YVejkfII852ckQknUh2VqykHesQB6oKNFUJ36IALEEK
	 tbwH6o9AePiWzxgRPIr9T6oHZUDEDjhBTGCVRSoCpDXyLTXJIfDoxf6AxXorNIzm9q5c8
	 CYWpBsyKMcR0hm/FW23lSemQExSOZowI+gwfvU0NnKBjUByrqRQ6BozjZ/IiG9lTL5Y2A
	 fHtxANg4ABuIf9nwv59iZPWb9XRifkPF+3FxHEw0WIu9RHbpKFj/qQWHWnAO5HVuh3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966728;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1zyx2Uxy4RUbuMas+e6y49K5/oKqZCnLjsukdPhSewU=;
	b=MNLPGOGnPWnvaSRgYoSqvlPP1Qr7RKKyyG4OoxRlTI7hKKokzHluZGPcZ4tjfGADs5/n
	 ZweolpcO6b1JvaQe35rMLDFFU5FBzb6xK4hqYOPl+idLTmM5z1nOCrIw0lWaPfafbzjrJ
	 YrCR1acE8nhTv9SKYybzD6uJw7baymfoT3ROhQryKsAnR989AnBOntGTz89FlNCgKQHKv
	 iBw2aOxSJRGvIFKUh+FRp/Xn4L0sy1FIIn/Iugau/JiFFdYC84M/X4DIlgKuG/aLC3IDT
	 C+A5Aj3FyC+EXchRz8aKfV4sK+LBy80s6PB7Vs0c/2ZE4eDzSfj+St9+pvRtuFQaV+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FD2BQvqv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885C606A325;
	Wed, 18 Nov 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FD2BQvqv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEF31F000C4;
	Wed, 18 Nov 2026 01:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794966727;
	bh=1zyx2Uxy4RUbuMas+e6y49K5/oKqZCnLjsukdPhSewU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FD2BQvqvD1ebkI4yVM0HQcKAE7af/nMis0MsTjUR2Kjz0eWrGbp4I8cDd+Um7qeYv
	 VANnsw1ZrawZKhyDGXan3S/1i/RhExLR9Bp7d+8SdkPl84QdsxZ9iGPVpY4CGHkI7x
	 TF8zPVqK+vYtZuSok0CD6KnNs8Je0CCSLZBDXYPnA8MaEP63M4R2GyP2UwqEHKQs4P
	 134VcKgsCX42/UWsYnMXgJcgUxD2I4zc9A6zhs3RApNjYrUlirAyFJWOzRV4dSuThn
	 W2/ls1HO29Z63HN92pqWJfUfbs4Kg3CdKLIJ3UViTwmzABYwTmuTLcE1NqzqUnELFg
	 ARXqlSLEmUlqw==
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
Subject: Re: [PATCH v2 1/6] mm/damon/core: introduce sz_ops_filter_passed_last stat
Date: Tue, 17 Nov 2026 17:51:59 -0800
Message-ID: <20261118015200.95836-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117-damon-sz-ops-b4-v2-1-439888fa04ac@uber.com>
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

On Tue, 17 Nov 2026 23:22:15 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

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
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
