Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2E4682
	for <damon@lists.linux.dev>; Sun, 25 Sep 2022 23:42:06 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id 63so6407852ybq.4
        for <damon@lists.linux.dev>; Sun, 25 Sep 2022 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CgjSy+2ejnk7MEuLqzJRIcaoiriN+DzQM58IBT5sbmU=;
        b=MxB8kuY/Jz4suS30u9gdMCg1NmRHy7jGX3MdABghdLVr87NI4IIfTxzPGNHmTc6NAc
         nn65f3mlzPiwW0dWwHiDLD3IX9RmQLYGbxPkSER9kGYMcaZ1u6aiOSjwsBH5d5gpycSx
         /rTFny1tquqJBimXFj8CC6Oh1d7ML8gEPzwtN6xGGASFMGF49WRNpsx/M+gbK2xzR4c5
         NrErPgXkzxcJFQxENcNnwgmdeateH1gt4cntx7SEm/BG301zsG/VX0tvZBWE5MhNhWKQ
         bh1BMpGQR6J6Spqe34TC/PDbX79XiXBoJIkXjLmFEb5lwMdBD7ltdoGlmFQFjdE2OJ99
         lg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CgjSy+2ejnk7MEuLqzJRIcaoiriN+DzQM58IBT5sbmU=;
        b=vOnub8sIPysC6s/6nuo5Y4Ka+T0mR8rKMHdG4oWLqZKjNRidjVIDi/P5pmmOWjHnFO
         57Lw6aFDudSiJD2RPHZCpgcOC1XMuKKRI/LVcM+PX5LVgjBHqnR2VKCucsNKQwiUnohr
         qVsosuEA6c8YvRnB6dqDarIptFDkP/Oxyu1n8dW2c/P7ILRwpxDAXbLsBBq3DQWOZo/c
         mD5yrRBv3kxBKvm97OdFJ3yy5aRTTZ9qMPXy6kSsNLsZH63KzDEsry6kjYtUbd65tSMt
         dleZJlYxXkFzbB4u6gQ05kFnXJmlLjn8rCt61gineI4UhZXQhwjwkYQWk9gKw+o1mvyl
         h4ew==
X-Gm-Message-State: ACrzQf1+KDQyBF1KQa9zdelrqhzEMOjU8UaKoZqYnMjyyOTCYv/4VVWL
	vOZAcCXQFrIuOmiePjor5iR0uv1d7lOEOyC8iHI=
X-Google-Smtp-Source: AMsMyM6jHUKcbAFtoCv5LF/5Q+NMxVdnL6cMpTsaDqZbOOLOzz4Xl1cKu4aR7s7RrcNe0buZZ76/6elkRkDjbl5CKLU=
X-Received: by 2002:a5b:1c3:0:b0:6ac:c87f:3dc8 with SMTP id
 f3-20020a5b01c3000000b006acc87f3dc8mr18240908ybp.547.1664149325368; Sun, 25
 Sep 2022 16:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220925234053.26090-1-ppbuk5246@gmail.com>
In-Reply-To: <20220925234053.26090-1-ppbuk5246@gmail.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Mon, 26 Sep 2022 08:41:54 +0900
Message-ID: <CAM7-yPT9yB6R5FVaip+nv7NRWQvph9fMgYyBGqPVoOUVwD0uvg@mail.gmail.com>
Subject: Re: [PATCH v2] damon/sysfs: Fix possible memleak on damon_sysfs_add_target.
To: sj@kernel.org
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Sorry to make noise... I miss the fixes tag, resend the patch!
Thanks!

On Mon, Sep 26, 2022 at 8:41 AM Levi Yun <ppbuk5246@gmail.com> wrote:
>
> When damon_sysfs_add_target couldn't find proper task,
> New allocated damon_target structure isn't registered yet,
> So, it's impossible to free new allocated one by
> damon_sysfs_destroy_targets.
>
> By calling damon_add_target first as soon as allocate new one,
> Fix possible memory leak.
>
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  mm/damon/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 7488e27c87c3..bdef9682d0a0 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2182,12 +2182,12 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
>
>         if (!t)
>                 return -ENOMEM;
> +       damon_add_target(ctx, t);
>         if (damon_target_has_pid(ctx)) {
>                 t->pid = find_get_pid(sys_target->pid);
>                 if (!t->pid)
>                         goto destroy_targets_out;
>         }
> -       damon_add_target(ctx, t);
>         err = damon_sysfs_set_regions(t, sys_target->regions);
>         if (err)
>                 goto destroy_targets_out;
> --
> 2.35.1
