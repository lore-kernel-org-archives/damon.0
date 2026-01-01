Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F221D5BC;
	Thu,  1 Jan 2026 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307464; cv=none; b=tC+JZN+orSng7czmulLkKj0yBy/RWTFxak6gRWKiRSRLSzyVRm6nwiheTjVXwoAwfzLaWH9o2tYGnowbh3srTB/DiM4w5LSnEB+RQRLdsKgTukMo+aShccfdMlBD+15cjC8GU49BOBcSfOocFQqByd2RM62rdZGta6eX1AKL+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307464; c=relaxed/simple;
	bh=XmjtJHTHxjwd7ITB1Y0Try2fxeiVf666M3I/4f/D41c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnP2jje4U2P+axBaYA+vuJWZ+scyYhq5e24YX6FxE+c71foZzkxllAVZ+a/THSyd4Mni/BUk149ZXyHCEw/yYP2nu+omF3KsxQj8/HC/lkiPZH344EK0zxH6VWF9FpS5bilqpY2+KwxzQQEDd77GPvtQdHN9sfnYpsqh8qGvSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekkAZUz4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekkAZUz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5585EC4CEF7;
	Thu,  1 Jan 2026 22:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767307462;
	bh=XmjtJHTHxjwd7ITB1Y0Try2fxeiVf666M3I/4f/D41c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekkAZUz4NtXIlXoQYj8OIW3Ny0kLmMRUdRxjI2M9tkYMEN5kVdmyOScLzB0jbABYk
	 bWiwPvEy9nMFDuE3O93YG2GTzm4+FDCpvJdT9G7NOvPZNhRxA7NDwBID0BdMMbkPRB
	 JoFgxnnmcV9mczNdNYaj3L3HZnNbsLxufAgk2eKEnnMCjUFEq9YZlve76X5ZkyxpCV
	 nyybnFKdRlSA4ReGnaemO5vOSKuTKwdiwHIucmEYKc0GPn0brNVOwbWhDUBKcgg8BD
	 ghccf0+kND1Lrs3pY8PKIYt2MDP2uZO7EIrA1zn3qdT373u93tU5rd4WhaIVz/mQ3I
	 pT9LpCKjI5uPA==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
Date: Thu,  1 Jan 2026 14:44:19 -0800
Message-ID: <20260101224420.73826-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC5Frn16MiaP7AjzvJNPfnGXyjcWmhtwNnKQzXwz3VUL9w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 1 Jan 2026 11:34:13 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
[...]
> I'm sorry, but this conversation has gotten so long that I'm getting lost.
> I've given my opinion, so I hope you understand.

Unfortunately I'm still not fully undertanding your opinions.  But I understand
that I'm asking details about your opinions, more than what you can answer at
the moment with your available time.  It is unfortunate, but I think asking you
more qeustions will only stress you, so I'd like to accept this as a
communication failure and simply forget your mails you sent so far regarding
the fix of damon_call() uaf issue.

That said, I believe you made huge amount of effort in spite of your limited
resources.  And your report of the damon_call() uaf issue was really helpful.
I truely do appreciate your effort.


Thanks,
SJ

[...]
