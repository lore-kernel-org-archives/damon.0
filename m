Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434225F7A5;
	Sun, 31 May 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780244702; cv=none; b=QWcpu4fgdugZT7Lwx1ejNK1/PicsPAY5uUcZZqpf0iIt0PrhoyGc/WQHOPMQuimOp5EMKc+sypTj1/Ht/SGZzbRB6wL8T121QO/G24m03xkbMXREBfWQBaPSYHTBALAZr0Xqkg6PzhSSy8iIh2sMpJAIFJ9+9moFc3QNwW6DZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780244702; c=relaxed/simple;
	bh=y2rgs2gLrTZGN+TFgoSUZnva6UPvvW6hRWAgr8ltwnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOkzC5sEsFtdyUPPZbqsyE/SA5Y/5uOBbIRRCbQDt0OvQ+B2tBuofQx1CsaE1rXiT4Lx2rqSu+05Uo37RT/NpDb1UqfJvPsz239Ps4sBfzuRO7n7hw1mmF1nT0fLZO377YzlQ5Y1DaYNTSQdFgJbL6d96sZj9TrifnSI0bTw3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH8R+L8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH8R+L8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955F81F00893;
	Sun, 31 May 2026 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780244700;
	bh=a4xwiQThCs7F6+XmjiaWulJyRMq8uwTndHHdVcApUeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HH8R+L8HsK2swvjdoSOvXv3+R79dEhpbNVvX6VDjStjqIShSbGmPEwr2fYd8Dl/LK
	 JLEb6N5PGpp/LY+/L5yvIBi+ueq4Q7VOfEcBRuhqgyDHs9HTFQGS8o1ICSzilFwmn6
	 t8aRDA0UEoUXgw6SMCErJ8xPNmPdWjvU01VmGRVqPoEI2d7cwrO4eScHqNfW5XuSnm
	 Wj83jVeKR7nPAZCE5vst6YxFiJB+zgJyGJLW/0LXURwk4NJ2NIJfa0pmrpHAUQX0SQ
	 Q9jOPabpqBfkIXQtWhqJDs5JrQvOv2N9RWEZOPZ9OzZns1/04r5Xmmjq0oUHjQcVgq
	 up3Gnj1ihLZWw==
From: SeongJae Park <sj@kernel.org>
To: "Kunwu Chan" <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	"Kunwu Chan" <chentao@kylinos.cn>,
	"Wang Lian" <lianux.mm@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix stale TLB young-state handling on arm64
Date: Sun, 31 May 2026 09:24:56 -0700
Message-ID: <20260531162457.98724-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cfa837d8641972b79a404f4f9d489644dd6675f7@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 May 2026 12:16:49 +0000 "Kunwu Chan" <kunwu.chan@linux.dev> wrote:

[...]
> We think that makes sense.  Explaining the rationale for not flushing TLB,
> the limitations this can introduce for tests, and recommendations for
> choosing reliable test working set sizes would be helpful.

Thank you for kindly accepting my suggestion.

> 
> If we later find cases where the documented recommendations are still
> insufficient, we can revisit more intrusive approaches.
> 
> I'd be happy to help with the documentation work if needed.  Please let
> me know if you'd like me to prepare a draft patch.

Yes, please feel free to send a patch! :)


Thanks,
SJ

[...]
