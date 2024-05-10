Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40113B59F;
	Fri, 10 May 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376096; cv=none; b=nmS4kmvKNJ3sGMgvz9378Lg/oMRIOVZXIbqVfvQ3c1rWGa6RAFeH2FYonlZu7uyxaaKkVRAw62TYHwrsaVi0pICTnWGjunaek7J44r0Xwn7JfnStRZ6J8EAuj7h8UV11Qd4DqSXhCq/JtThmJ+3EHtS+MjQSIUBYOipx61byxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376096; c=relaxed/simple;
	bh=hMEXmQRGLaA0wZdLWmzo8lYtJ7sJke/DzESnNNPCttc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qn/xKZnVZDL6k6O+/kl8SZQRj8lBu3/z89AzoUSSpuevSw+urxd9WVdyhvtwqMHxHcZ7YKoNgji61L/VpYPiTunQYy9VEn0uzazcHEpswL3PR/gprVtTdrT3iW/4PwmO89YM/MLF8mtbO+dlYetXnLsrj4QF8Civv0NNH9cx5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yav6QjPF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yav6QjPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63D9C113CC;
	Fri, 10 May 2024 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715376096;
	bh=hMEXmQRGLaA0wZdLWmzo8lYtJ7sJke/DzESnNNPCttc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yav6QjPFQof0/7jVknTCRr/xcRAOmajttY8HnJM9k3WOQ4a3EsK9Y2KctAnDEJBhI
	 XPpQhrjkfWmlYrOtqisarnTDq3K3BidksZGuslGel0mZtamMXjrwPE5on9g2pic9X7
	 RTDl3lgLUyDz5Vyd9zTgo7H1lvv3l1f4RjFsdJFB2FLYqyrcjjOnaPygh9UQr/8Md/
	 LVh+K2ColVGziaH/dRg8W9GJOCtmeuSUKp/E8w1EvQs780tUAaF/8KG6Xk8jKm7sRt
	 3h0WikCrS6Nd2FAX9oCt7bxC6uiO+f2FSD+FZpJjNNejj1t/anLPUCgmXQNhLjWOer
	 481fv24lixWtQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Updates and Plans: Automation of DAMON tuning, tiering, and VM guest scaling
Date: Fri, 10 May 2024 14:21:32 -0700
Message-Id: <20240510212132.83346-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129204749.68549-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


On Mon, 29 Jan 2024 12:47:49 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hi all,
> 
> 
> Thanks to the discussions and feedback that we received last year from the
> LSF/MM/BPF 2023's DAMON updates and future plans session[1], DAMON made many
> advances and yet more future plans.  I'd like to again share/discuss the
> followup changes and status we made so far after the last year's session, and
> the future development plans on LSF/MM/BPF 2024.

The session is now scheduled for 2024-01-13 10:30[1].  A draft of the slides is
also now available at DAMON slides repository[2].  Please note that the slides
are only a draft.  Those may be (significantly) updated until the beginning of
the session.

Looking forward to see you all at Salt Lake City!

[1] https://docs.google.com/spreadsheets/d/176LXLys9Uh6A-Eal2flrzcbUSJMUXGkGwyihr9jAAaQ/edit?usp=sharing
[2] https://github.com/damonitor/talks/blob/master/2024/lsfmmbpf/damon_lsfmmbpf_2024.pdf


Thanks,
SJ

[...]
