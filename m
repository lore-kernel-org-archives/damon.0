Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395B15A3
	for <damon@lists.linux.dev>; Fri, 23 Dec 2022 01:04:44 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id m2so3279628vsv.9
        for <damon@lists.linux.dev>; Thu, 22 Dec 2022 17:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/gOWZAaD8SBIOiOmfYa59YShOa8ycZ4ayxBa1jRd7E=;
        b=tmaHZMPcPeETZRodOkbShU4wP1wCu3ctqiGNC19OZf6gr4rulXNp5EZfuq4CH5y8N/
         SVjpjpbPPAoe8VlZ3gMgUYszT5U8lshoTljFb0MQZurhw2j2r5wnY10LW6cdWwlX36hR
         YTOaluFUI/V4/SVekarIA9spgFf4y2lXk/q1+Y0Gqn6rywM979v4uR0kB47S+NIuMsXh
         2R7jCVy0/sMWNjjqT8SQjPMyy79DXKkv+t0nw31l8oNTDGGeVYFpeAanUoqSKZOi1lKH
         C134VdbgAdl/NzxqVQQeNNpmdHAp/H6yhJv05N+nJNZYBVQGxQtoLjkQfbpMDug7svf7
         4z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/gOWZAaD8SBIOiOmfYa59YShOa8ycZ4ayxBa1jRd7E=;
        b=DKqIQnTLdB09gOJcFgbZAtpwuIVUhOQ4MXgbt1+JvDg3es0QC1qP1dROUfE+FiyZPK
         qjie8T2Q1BLCh+QiKkNEhiMrdhF4EpviFrETZkcQ5ggk0luOjGm4YuluVl2mXw3vO8EC
         ZB8ayI8l+9rRv5Jg5Gw76WBREPrGJhengo95CObOyU7sRDPphNiVD6AzW4UFC6tJiiub
         8z4zxE1Xt2axv6gifrgOK6NHjJXXcrXaEbXj3wjnaLJeUB1/txeAaTVoG4UpDtLTtOZK
         sQFmLNDz8srNT0/XHcy5HlUpHwK+CWQesQrahrVc9bCbUEp0xDMsOOBbfXz9ZEPSFe2a
         5PQQ==
X-Gm-Message-State: AFqh2krk6RTwS2jRaIOfCgvDd9+o80NL26rv4e6zOfHHZQ7teJCtpBIj
	NoZIAJ3EVRwtsnuPfn3Dcj6cAmPwkXqzruh2h9mD+Q==
X-Google-Smtp-Source: AMrXdXv7OoxaKXo2t6mAbAu8R8miK2JpT2IH8nH1wkesWFiDSJdnax1yDykm+3t9ZSiXE5Sin8BXXdg5tAj231ABRwI=
X-Received: by 2002:a67:c486:0:b0:3aa:f64:fbfd with SMTP id
 d6-20020a67c486000000b003aa0f64fbfdmr975101vsk.15.1671757483050; Thu, 22 Dec
 2022 17:04:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221221180848.20774-1-vishal.moola@gmail.com> <20221221180848.20774-5-vishal.moola@gmail.com>
In-Reply-To: <20221221180848.20774-5-vishal.moola@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 22 Dec 2022 18:04:07 -0700
Message-ID: <CAOUHufbcp+VoNR1uonBYi6eEeoG_Td5N_E1hkyaj_gRmRc4vwg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm/swap: Convert deactivate_page() to folio_deactivate()
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, sj@kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 21, 2022 at 11:10 AM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Deactivate_page() has already been converted to use folios, this change
> converts it to take in a folio argument instead of calling page_folio().
> It also renames the function folio_deactivate() to be more consistent
> with other folio functions.

There is one more in mm/vmscan.c.

Please git grep.
