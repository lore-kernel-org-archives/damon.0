Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74152236FD;
	Wed,  1 Apr 2026 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005149; cv=none; b=FS4OaASFCVCckfEJF4lKa6irr+SNei8fuyjIWgr2WlJ1Lr6sMD4FeFhk2n6nQt5tdXeF3DmQ+DgkbQFDGw/MgQ+delUANisf2dvm5eMNcmS6BtstV16rKEzRHywprvIH8Hvhpn0Z9NN8pAAjYve/qGf/PnyRxGZtt85pzFd9I8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005149; c=relaxed/simple;
	bh=vlrwwARqJyOsWvsUI29VDJAa3DH8Mh38OVXxiNATEv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsUXsiMdt/2IzNX0nTIIeCpZ0tqin6FDi6wPisnpzEshrPAdUbysbvYQqGQm7iA1iwwQJkuRaTQmB/fL8ETog5X6SsIn7MBE1JoeHT6cF310drUPy34TonPxYsKmO0+vUZT2sJS+QLQ7dnq/TK8UFIxSGOjFiijTA0WHNhUmljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpfeV6vm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpfeV6vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C6EC2BCB2;
	Wed,  1 Apr 2026 00:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775005149;
	bh=vlrwwARqJyOsWvsUI29VDJAa3DH8Mh38OVXxiNATEv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DpfeV6vmOJE94JC4YmwmGxhAYT13SF+q9j4PN0LkzexOkXJtKrfyIDylj1mXyh6dA
	 T+QJlPEe3K96waxCJUkqkcODvzE4Ca2gwyac79tr+DMkwCkHWFYdjDjgn/5Fz7MGW9
	 8DQEOrGJ9mGfP/gftMTI0F9169kOcNcynWBo9/J3lQnnpPdp1awpJJUs44XsdrX0OX
	 2OJNzQhsKejzkJKbJ6zJjO5cL4I4ww7HiyIOe53jMmayWT0iYUYjhH77jrr5NcnJp6
	 NTMgZI/C2YJkw4EhCQpvD9me7KMFxJvIdKvt827ncwxHqtM5PP/bxWZBsptDaGCZKn
	 vyKpHddEzwVmA==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Tue, 31 Mar 2026 17:59:07 -0700
Message-ID: <20260401005907.86002-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4fe88a6b-2d9a-455b-9ab0-5ff153e0e88d@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 18:15:50 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 3/31/2026 4:31 AM, SeongJae Park wrote:
[...]
> Thanks for the review.

Thank you for generously accepting my suggestions and answering questions, too.

> 
> I will run some more tests today. The test try to hit every row in the database,
> which may not be realistic. Usually only some parts of the table are really hot.
> I will change the test to get something closer to a normal distribution on the
> table hit.

Sounds good.  I wouldn't strongly request more detailed test results for this
patch, though.  As the idea is solid, just the simple test showing the expected
behavior is already good for me.  I'm rather bit concerned if you will go down
to a rabbit hole while doing more tests.

Nonetheless, if you want to make the commit message more complete, I have no
reason to stop you, either :)


Thanks,
SJ

[...]
