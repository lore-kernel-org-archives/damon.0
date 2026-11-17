Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882688;
	b=r20nMcN9o4kTe3Cplk8uwtXGc/DnPjDR/mEzdBbKA0hMxGhsAut/o+FQHp1SnTSKIaJO
	 DdiOUEhEytaKwxH4NsZ3y33TnmnIDBFbljwvanJVS4GmfOVgYGy5g0qfoIRpSaBI8zauy
	 Po4maNJE9kPdJu+4TTSehjbFR7nZ8Ku/zVFaGm/bzUzttPFBS209meYO7W3uzmwEYs3J6
	 e0CoGFtt4Aq8W+QgAYYDEIYfZUJBGtfqsNI02vD3ekg/iuc89IsTF/+On9CVsL6PaBUpK
	 xvfDsVzsOC4RvF7/3+dRlyL+lZNZNr2SJ8O0rmf2guGRCJRTNa5dE4lnRInLxQoYnsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FCI0ZTIYgpjkp1xihqDqQLBdIOvJgrIfJxEzga5fc10=;
	b=UX5+4iV1NzghVfVvVYZG78c2VjEHOs11k1I7P/Sru+tyUTIlj3bKS63hjYPb8/3SaA6T
	 pJgGsK+zont+5iqRYQkcNp0WFBf0CM286gLWZ0FSRivdYcQGAGXB1MgZKSBDB5OiUGw6k
	 OsgxoAasEdOnBGEIcRYli+IYXdCQUMq4mU/Mdn30N0L1Jmj5S3n4wLObSLAIHn/ht/Nzs
	 Pan3CQOchAIgoXMzloBz2tOLMwK+yG7PJLPH9u0JftQSxBZVyTSr6VGf9wMvPSUFT8w5Y
	 CdUyZmgcDJb7qqge6W7xoHNqo+BbvDOrk7w9WqFOQ0kOyhUMpPTlcMLw+f9RNaPwpjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSZeaabF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3712606A31C;
	Tue, 17 Nov 2026 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSZeaabF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F5E1F000C4;
	Tue, 17 Nov 2026 02:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794882688;
	bh=FCI0ZTIYgpjkp1xihqDqQLBdIOvJgrIfJxEzga5fc10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oSZeaabFsDqhBvaA9sMQ/mElCYGAuc3fuLIcmD7BCB4z+p1LH1kkTDxvDGmli2Ina
	 ea6wR8P8TSN1aOdx9FSS2aSJO9pTR5E16+isUsM1sDxpwlzou2r+k0aQQC9qHSC8Af
	 C4QUQGA9u7GLMnh2p44/lE4MIsTMyMPQ8JtV7UKKGwRGtwoM7oYpK+r5r5jRtyQ5H6
	 V4cqTLBXVHAnXzBjPxedsz/TlF37LElNj4x5NrUF3+CmeUM3WWK+KDdbwbkdDX5apT
	 lF8zHCu4tdVfkl/QtfFw7e0/l0B9eCJMawvL4Qz3y1VXsZZCT6wp3FPbxJiTwzfUAd
	 zezyEhhrbWYYw==
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
Subject: Re: [PATCH 6/6] Docs/ABI/damon: update for sz_ops_filter_passed_last
Date: Mon, 16 Nov 2026 18:31:20 -0800
Message-ID: <20261117023121.110826-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116-damon-sz-ops-b4-v1-6-1cffe7227e6d@uber.com>
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

On Mon, 16 Nov 2026 19:10:09 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Update DAMON ABI document for the newly added DAMOS stat file,
> sz_ops_filter_passed_last.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
