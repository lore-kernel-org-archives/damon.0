Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795889541;
	b=XGs0AH+CckUvwWwmFy0tUub1BLUIthYmtTmlen3l5G74BHFvh48/K4Y8/J1hXNUrycFg
	 maPqhFUNmLeH1tLbLkEvAbAZoxwn1RABMUeZPQlOcMBbaMtXRQpyfDyq/HgjYBI2kDha8
	 JbQjczt6xxgGLjXiOA4HkCDa8hAIPI2DMQ0F6Xy8AljNd12JnuOIDD+ICBNYWya2A2AQ7
	 iv/zMUjKjYr4xfHjn+7s712FRTTeaUq/qb6Wx0vfUY3lVtXmKDfSd1lyWgyHSmvafIBLp
	 Ro4nqJj2jBd6F+blreN8U33/8OZejqk91OwjIcQvBjgYVBaXqJ+CEfDivMsgrgZZMTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795889541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ku/YdH+wh7gG7ORXWUhOFFSWR9aa9JxuVP7AopMyHRQ=;
	b=L44L+Gm6+eJ8gWN1PjMZTTJdQps2KVb+YFA4+6UFYZJChKpskUhZN+fcXohaXGzjA6ey
	 318716HVJLY969pGqreMdGk/i5vq4RDqndPoHWiv3oEIuvZF2oNQdTDh0rv4wtJ+KRmBL
	 ttaN1iTNL2hdDvz2GhgNPBcxjfBITJxo7YOrV9HGH6oMAGFnSgNltLyQ4sAlc4+7ICAjP
	 S8ymy/F7r/ictyJnjAQGDEZBx+HAVu3/ZAbC3wP8yYft4LdS59D5bmjt//13BCj9YG3eD
	 W/8jxyapv8p3t+j/N/zzmN4DNBnmOx7pV/uKKNk8ieTNZ4eXoJGXay8wYBFVrtSS4yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIuSp77N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D543606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIuSp77N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47C71F00893;
	Sat, 28 Nov 2026 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795889540;
	bh=ku/YdH+wh7gG7ORXWUhOFFSWR9aa9JxuVP7AopMyHRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mIuSp77NR6bxc+QquZxSZCHy/CsfzI36N5/Cqz2uoZo8vVKMjLDT2VOKN5GNl1lkv
	 ygYgzZJWG2q8rfSr4uoa6Sl3g8ROTzJniaxZhkEp9rMNOYKaBE8dsiDc3eqfqqC/Fu
	 Sa21xFog3/Tm88ZDqbn5cNiikxLLSFGZnECFwzk2iEMS46Xf4thlCD7PScTxBUNp8F
	 PUMyKsCCZsq382gwsUXRJYCN3TV4VS/kWz0Sa1+4Wt2TJX5mPjtrZ7+W0wY/O3znIq
	 onHTmn2dDWJ6I84oMYbOgRIBC1jQqhZN7ATkYnm6AGdewQQc1hBLrZzwy1u1pp6fho
	 Lo8yD8ZlE8exQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 4/4] mm/damon/sysfs: remove damon_sysfs_cmd_strs
Date: Sat, 28 Nov 2026 10:12:12 -0800
Message-ID: <20261128181213.169533-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126210619.97634-5-sj@kernel.org>
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

On Thu, 26 Nov 2026 13:06:17 -0800 SJ Park <sj@kernel.org> wrote:

> Remove damon_sysfs_cmd_strs, which is not really being used.

NR_DAMON_SYSFS_CMDS is also not being used.  I will add removal of it to this
patch.


Thanks,
SJ

[...]
