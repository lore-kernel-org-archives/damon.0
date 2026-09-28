Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414C4D90AF;
	Mon, 28 Sep 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614590; cv=none; b=KK8fGIQDpGeNB6yhr0Yhhb7Qu9Zib1hYzb9AQl92HMfT0OS98NvOj49nFNUnyWrnAX/IizcQiq8UkkoX2JXwP2MDa8s+yD2sP3qrt0/Yr9njeTK2M6JqHg4vRYM9uO7P442MSt6U6B8yAki90Ogw7REGMnr12uPz1JmDiZhG7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614590; c=relaxed/simple;
	bh=I2BetFeSEOimiagM5fZoUJYuONuerQXiE6VR6C3lLx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JS18e7WqVfvx3/auiRymnSZo/ws7GHdyimTQYNnbXfLgomnXnXHrZh6G6bZX0jI3r0M/FVfKaxYzNEfGwCG/y76lRt/CU6iUFHbY245ye4MEXz3wPakXPgR+CcTR7CU60kqS1avoru/NkBnRYNJUFiyIYhqZH4PhyjLPdhZ2V6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlxyqhuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlxyqhuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CC61F000FF;
	Mon, 28 Sep 2026 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614588;
	bh=qdMdQ7xNoZT0JPAPrDLZpRnRksX8EJod56eBhYE2+9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PlxyqhuNqRl8HaNDmVdbT+HILDG54Fx6nLK9YGA8zHZwvvHeEUhVe1JQIGH8iTacq
	 8y5MEMW3W5MaIZPUOaXBuAOesY18jLR3zkhGNriuTfbwfyCl+PG+tvDJxx+YPjDyHs
	 wxGmmhsuinQi7MTzj6li8NyL9BFRWdAxmUC/DdvxJocRYPa8n9QMt0hthYAL4zFLDF
	 ctll5WnKHJNHpGpCACfOnf0NLGg9SZ+TI0ml/qJ+PLtJaACtH1HQa7C1zWEXhWPCOY
	 qs7b0qD7jhVRLBvlRCOa3eyuo4kKzFWahoMP/PIxbqj8dIuVrxrfFfL7gxMiNyvNCR
	 Wv63+0e0ws+mA==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [RFC PATCH 0/4] rust: damon: a first small step, plus a Rust prcl sample
Date: Mon, 28 Sep 2026 09:56:20 -0700
Message-ID: <20260928165621.18850-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b1774aea-aac7-4399-815e-19b830d883a9@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 20:59:45 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Hi SJ,
> 
> Thank you for the detailed reply.  Comments inline below.
> 
> On 9/27/26 18:07, SJ Park wrote:
[...]
> > I understand this patch series is a kind of experiment rather than for a real
> > use case that has a hard deadline.  If I'm not incorrect, I feel like this
> > might not be the best time to start the experiment.  Could we wait until
> > fundamental parts including module parameters support in Rust and ongoing DAMON
> > reconstruction, or my learning of Rust are done and stabilized?
> 
> Yes.  I will park the patches and restart once both are true:
> 
> 1. Rust supports writable/sysfs-backed module parameters.
> 2. the DAMON API reconstruction has settled enough that wrappers can
>    target the new interfaces directly.
> 
> Meanwhile I will keep working on DAMON in C as usual.

Thank you for accepting my humble suggestion, Enze.  If anybody has different
optinions, please feel free to weigh in, though.


Thanks,
SJ

[...]
