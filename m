Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4B191;
	Mon,  5 May 2025 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472496; cv=none; b=Z8GjzIveCrhJPo+6Xtoa+0XhR8XmF1uVNoWuS0j7maRiJHXW8zFgggJmFOfMIIpMPLqH6GpYVEEGCPRH0dSTKqRR+5m7junDwhmZYSt9UDeFSoTj1J+tgcBOKN53QG92rqaGR3HXip8BC9m+ERIbGgHgKU9iQFUHxeQvgw1OWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472496; c=relaxed/simple;
	bh=NlzBPCyS5J3dHYLB1l1HdmoHF04R/z7n6K/atBhdzC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQDJh5v/rIq46W5lJBpVAug+xdjCM1pwIRpOnRmKy5k4nc4LBIRBdGRuA1/ZqRbb9Ms81hXEqpMvexM5219paUSMPA9EFzFxtwewUbmBensNtX3AsNhskK+BJuQeV7hGRO5wa/oevNU1s5JGXxF5iJiXn9xmz0/wKAH3/KSzdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0t7b+s7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0t7b+s7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAB1C4CEE4;
	Mon,  5 May 2025 19:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746472495;
	bh=NlzBPCyS5J3dHYLB1l1HdmoHF04R/z7n6K/atBhdzC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0t7b+s7oWn0Wem2Z5CRYnbu57fDpjh25hKSar4Pk97r4ofbYcf8xGkcWcoi2DQO2
	 zJUZjAt1rfJ4Ou4Cr2EmFaom7oGuC3ZHibzIBeGhFTgdsjPwbn9zQyHHbvU35+gd6g
	 uPU5Y77GPfRVaLKSvxsfY4tVJ3ome6ZrC1QyZJcEzRuizwP6Mojvru9vFqKP8sd+8i
	 DcyS/DuUhL0QMjLXLmseYTn8iCYgZf4WRIAy13QJWoNaPp551tKjGBNbwTZJZ78d2h
	 jHgvu7z3AcjyuJ2tdzeWTWJ0cnw4zNDR2TQLHx4zlBVb0QJnJWlPGg1GIBHRQ6JyOa
	 FWuXrxC5BYOow==
From: SeongJae Park <sj@kernel.org>
To: "Thushara.M.S" <thusharms@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] docs/mm/damon/design: Fix spelling mistake
Date: Mon,  5 May 2025 12:14:35 -0700
Message-Id: <20250505191435.61036-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505185350.10171-1-thusharms@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew and linux-mm@

I think this patch is better to go via mm tree rather than doc tree, like usual
DAMON documentation patches.  I will be happy to be corrected.

On Mon,  5 May 2025 18:53:46 +0000 "Thushara.M.S" <thusharms@gmail.com> wrote:

> The word accuracy was misspelled as "accruracy".

Thank you for finding and fixing this!

> 
> Signed-off-by: Thushara.M.S <thusharms@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
