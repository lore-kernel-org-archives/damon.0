Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B421632;
	Tue, 21 Oct 2025 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008931; cv=none; b=JTgsHHtFSjGEgW38UmujSJAnwmhkxoRzNrqxlBpxMDyl7XimbVZW4/VUnHSo/0g9g10pFFDnEM+Qv3q2apV7sBjdfmSJ1duaSY6Iwegn/o3V16fhZXGFKpBGq8paNE4QS3rpV12JstHVZSMq0Kb9Xh2BsHxE1OZnF70sQM1OnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008931; c=relaxed/simple;
	bh=oxV6DkSuzv67RKygZK1LFo8YEpvX0EUdzoFetLXu8UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ooa5DdD7dq4aMhfdZsQHUcHY97BTixiwbh/YLiu/mLikDjHtkE+/HZwiFQBWdIsnmtyC+e3Q+5gfNE+3bk4FyU89rV9COxw2MjjIozi96zvtawGZZmqFF/zvygxYbrT8mDGHQt7IVAaZoS1eryp5o4t73fgKdafwM3sakAjqCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvgMIthJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvgMIthJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08544C4CEFB;
	Tue, 21 Oct 2025 01:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761008929;
	bh=oxV6DkSuzv67RKygZK1LFo8YEpvX0EUdzoFetLXu8UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvgMIthJ9SQxyaW3JpAr/WZsuYjZratdc9EjcLbPJRzPyBIU8k7kz2hbJVE8jrfWO
	 sHdgVx2arHT2FYNVnnsyrjunuNXpDv4Y/QjK029h/y0y/LZYGpFlsNlXb+9ENj4NNi
	 scNqrMwb8zEHl6Uw3Dw1Ql8WHfd16eoNbMP7beU495GzI34VcegiXTji4VVfb5tvHN
	 KqyNGx5mgBCrsttYPbdzmtqfJ3I1STv3Vz7jW/jxPkVAvfVwupJAlOE2QTTgnDoLQg
	 lia+48SNFDWzC5xbe4z3ZYglHnxmMAqbMgSHEXLlD6w0jVeXNKo4iJDL3+bpB5OXsA
	 byM0UDe8/TRbw==
From: SeongJae Park <sj@kernel.org>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list),
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] mm/damon/sysfs: Remove misleading todo comment in nid_show()
Date: Mon, 20 Oct 2025 18:08:46 -0700
Message-ID: <20251021010847.68473-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021021712.59017-2-swarajgaikwad1925@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Swaraj,

On Tue, 21 Oct 2025 02:17:13 +0000 Swaraj Gaikwad <swarajgaikwad1925@gmail.com> wrote:

> The TODO comment in nid_show() suggested returning an error if the goal was
> not using nid. However, this comment was found to be inaccurate and misleading.
> This patch removes the TODO comment without changing any existing behavior.

checkpatch.pl complains as below.

    WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
    #10:
    not using nid. However, this comment was found to be inaccurate and misleading.

> 
> This change follows feedback from SJ who pointed out that wiring-order

s/wiring/writing/

Also, giving a pointer to the previous discussion could be a good practice, in
my opinion.  E.g.,

   This change follows feedback from SJ who pointed out [1] that ...
   [...]
   [1] https://lore.kernel.org/20251020151315.66260-1-sj@kernel.org

> independence is expected and the function should simply show the last set value.
> 
> No functional code changes were made.
> 
> Tested with KUnit:
> - Built kernel with KUnit and DAMON sysfs tests enabled.
> - Executed KUnit tests:
>   ./kunit.py run --kunitconfig ./mm/mm/damon/tests/.kunitconfig

Not an important thing, but...  if you were doing this on the root of
unmodified linux tree, the command you executed would be,

./tools/testing/kunit/kunit.py run --kunitconfig ./mm/damon/tests

I guess it was just a simple copy-and-pasta mistake and I don't really mind,
though.

> - All 25 tests passed, including damon_sysfs_test_add_targets.
> 
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> Suggested-by: SeongJae Park <sj@kernel.org>

Other than the abovely mentioned trivial things, so nice patch, thank you!  For
another version of this patch that the above trivial things are fixed, please
feel free to add below.

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
