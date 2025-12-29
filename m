Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549532B98D;
	Mon, 29 Dec 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021783; cv=none; b=HBDSLN9JBfx90iJ1ZQWclDhDbtcZbQJqZAtQqC7VabkKzvcH8NPb4FiVK27HgKmFmLm45JR0HGT91oXkJ0XnaSnW/vj7aUmZW7Nn9gfBj2FlkRuxArrH75M7e0wcONdrcbV3/SDqrUUXddbJ23ENZOCa8Vq4zDnnZy/4t/6iM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021783; c=relaxed/simple;
	bh=hjLy/PceNw58V9dV1arMQA3XkITKYMDJEG7qcaYiXd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJO+krvb63hP+mU+zyxT41G3iToMqT4gI+4fiN4dlqeHAEII5gWdPzu+xgvtAv53Fv+kQeHacHEm4MybkZqlJiBQI6Vhm1kac9JPbzgqEWx4ACLL2+rcpH36u4ZF6yoSaNhLzounC6uMnUL/ruTKaXjAINp3vLTsnk7+QVKhIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gasBn2fW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gasBn2fW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7EEC4CEF7;
	Mon, 29 Dec 2025 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767021782;
	bh=hjLy/PceNw58V9dV1arMQA3XkITKYMDJEG7qcaYiXd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gasBn2fWJ//NUxKL9tbdOzF2iOSzTNPiq5/m0pGiDe93U97Scwv8eD+9RETnfvY0O
	 iuBi3UjXjvaEtfc63eKCkUcmLedLEFvXR5LG9JqmtusXEVqSiqbiKljn4YEjktnb6t
	 5gFWJ0txmmGVWitITkJJcCtmyqMDf56SELo8VTG8U0qqOVk39cnPO+MzCTb51nFEQD
	 HikzV64qn7+vpXjI9Oj2oQAgiQj9mrA9+qa9MDmHNpTUdaZQo7JcfizQP0ov3cC7cP
	 FKFM4sXj8GwVPFb7bKU/JpBr2Uju+jdPO2Mik+ceDzAhnUw84MhboGKReIV5liJ+x0
	 dH7xIrExMdh+w==
From: SeongJae Park <sj@kernel.org>
To: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
Date: Mon, 29 Dec 2025 07:22:49 -0800
Message-ID: <20251229152250.78975-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229145533.2437293-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,


Thank you for sending this patch!

On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:

> This is a minor patch set for a call_controls_lock synchronization improvement.

Please break description lines to not exceed 75 characters per line.

> 
> Spinlocks are faster than mutexes, even when the mutex takes the fast
> path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.

But call_controls_lock is not being used on performance critical part.
Actually, most of DAMON code is not performance critical.  I really appreciate
your patch, but I have to say I don't think this change is really needed now.
Please let me know if I'm missing something.

> 
> Initial benchmarking shows the following results
> 
> 
> # bpftrace -e 'kprobe:kdamond_call { @start[tid] = nsecs; }

Commit log shouldn't start with '#'.  Please consider indenting the above
command and below outputs of it.


Thanks,
SJ

[...]
