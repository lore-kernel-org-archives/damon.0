Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582836;
	b=uWutUB8j/pLL/93xKBFYyCMbHdc0HVq1tYdtFgD/DqR1AYDByWCluhdtPn9sToGutwkS
	 MF+Po9oU5C55DnaHw3xdrbkHJ0IhwR6u9f5MIFH+SLxeiBNc1SqFO+4aZONJ20RO8Olci
	 d3/5/8wIz3p7x+Vg65X8rBlq9vjGEiX817o/7o28ptrJwyG91I7/zHXG++SfBe6Oqr2sd
	 7UTA1ASDn52FSaIeVoUfGg0WCgaNtyi2OwweoQn9mTdjpVHxH3aql48kxrugj1GElcxUK
	 DD9Jg4Nj371ieNA+fZICvuv3jx+Z+DE17CDmMYzxNBzYCkCyZ/fCrlqbTIQpxM7m5Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582836;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6/DyrLQAwnaVdIlNNu/TcqCjNECAIqfAfCTOu9JpszU=;
	b=trhZ9dkFDgnMhaO6+9UNslWCrNHYlhwbrOJQ6pIPmhs2WW/45PcfH6BWMuvxpefYS8lb
	 TPKMxpUGwx7XCWbY5Kk3oVhgIIO4ITWMa7ZsDhAihw/wMr91UydTCyZoN9wCVciEazZNF
	 AfDkL2i4ebDMbyjrdxEqLmrmREXl4JNqHTBd8lbXRWMHhkMP7HQDeuOm8J0Kz+n1aUdQt
	 1R5rEfA8i2HokKwYMfa7zrarnu9MkAhGRfH+oYjEiIPx6Bt8O+Ts9ZaPsp0EXPz2EK3ji
	 pgKRWVEjdLZdw58vmbuACZ4UZSzZOqdjRbPTs0FIgmDXj3YgdTOS9y7PgMvDVtN7RcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clvSJ2ws;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49D606A321;
	Wed, 25 Nov 2026 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clvSJ2ws
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484571F000C6;
	Wed, 25 Nov 2026 05:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795582836;
	bh=6/DyrLQAwnaVdIlNNu/TcqCjNECAIqfAfCTOu9JpszU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=clvSJ2wsEVPXgdnUPsGMilKqq2Vs7zlX+sEDEY2h0DNxB6u6sHU+6YIYZBPI9xAUx
	 OD6DS1EKqMljYfDZxJGvlXmGqkW5TnhVbIes5XEhGopFf1VwXbeKg39oH9AcUDwRqb
	 tfNO1mummX160mXsQh3fPgYO0DzKKtzNRoMIGhT5u3nvbBFxzRXKsp1t0ajNbZRlkW
	 Obc6p7APVSrrS65Y9yh6jpr+i8CC090I8N52djW7hkcHCMENZeKb1gxgVIpYz6x2V9
	 JCGeZDpFRyLN+ZBVVNtH69K7rufxntzJsyO5hPj/9tP0vPotsT7YrW+y8LPaQNFrms
	 yW8csjpMktxVA==
From: SJ Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "linruifeng (A)" <linruifeng4@huawei.com>,
	akpm@linux-foundation.org,
	chenjun102@huawei.com,
	tongtiangen@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: support freeze kdamond
Date: Tue, 24 Nov 2026 21:00:28 -0800
Message-ID: <20261125050029.100568-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260409140609.59881-1-sj@kernel.org>
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

Hello linruifeng,


I was thinking how DAMON would work under hibernation, and recalled this
thread.

On Thu,  9 Apr 2026 07:06:08 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 9 Apr 2026 15:20:10 +0800 "linruifeng (A)" <linruifeng4@huawei.com> wrote:
[...]
> I feel like it is reasonable but I'd love it more if there are more concrete
> examples and/or observations that support this.

I now understand following problem could happen in theory.  If DAMOS is
configured, it could migrate or reclaim pages while hibernation image is being
copied.  It could make the image be corrupted.  As a result, the system could
run with corrupted memory after resuming from the hibernation.

Users could work around by stopping or pausing the kdamond before hibernation
is started.  But it is easy to forget and cumbersome.

So I think your patch is better to be added.

Nonetheless, I think you should replace kthread_should_stop() with
kthread_freezable_should_stop(),  Otherwise, it could have kthread_stop() /
freezer deadlock.  By doing that, try_to_freeze() call wouldn't be necessary.

Would you mind posting this patch again, with the above elaborations and
changes?  If you don't reply in about a couple of days, I will do that on my
own.  In the case, I will add your credit with Suggested-by: tag.


Thanks,
SJ

[...]
