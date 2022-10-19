Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C95C87
	for <damon@lists.linux.dev>; Wed, 19 Oct 2022 23:58:52 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id h13so18718969pfr.7
        for <damon@lists.linux.dev>; Wed, 19 Oct 2022 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7UEu9uN2ujKdPAho6ZZ2+DbdoeogY1gQhveka0R0iM=;
        b=hkIEFJl5fqT9LPr7UECybhdEDjAQkqAF3gFJOSS95ayVIr52uSkCWyen48delTpr5D
         v1scQl/6ezefaE6KzfnhEOJBTShPpWr0GZmww0/OUJEiLsvTKU10OqsZZCytTnYDfplP
         GAcJxTVNPVJscjYHyv4gOPKeTMVSp/+0RdlkbnxQzJdpD0uYXAw+9lfRYGWYRQMrXBzX
         MPVN6+rQkbyErqDxpb3h9nUhd6C7rQotipg30vdga5kHAPXPbNq9nJMEDzcI0TH2SVnb
         P7FPMCIXAd2DtZRj1OYPXVlmLkyXQMW+HB+D1tORcGxCpNZ9tB2g+dMKPUN0XDFDmvUK
         PXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7UEu9uN2ujKdPAho6ZZ2+DbdoeogY1gQhveka0R0iM=;
        b=Tu4zwTsrKggg427GqxD801eQxQqwJfRJivEMWO/c4rvBv9WZXTr6rShf7sld0Mzh2S
         52fFD4gKIAvLFbs3aZodkaJknqULc3V8aiX9a0mPleULFnOBO9/n9nrDviUSEJOru1ow
         nhH+sQ3EkHwGV2H9/uzM4DLLEEUuW4KhdQpPRaJfiu18jI+iYpITS1JIxlOnfkjvXYSk
         UY+LhjZEJS+vxCi4dWdSFKQOJuRCJlrTp+qfvCtxSaA5BRU2qfke9JKUiO9fnftDvnSe
         /Z1yin/Ghg6rMmgCnnyALGbD2B8R1hyY3MPJsniapEvwaMqeFRCzJMeDu6jhiKhmGi0X
         xr5Q==
X-Gm-Message-State: ACrzQf0dmNWb3Sw57wPWm/CCzACiD+JkRjKdqUNjHcaocj4/AVEEEhhO
	J4l/nBCdBQF0mMzjTm8JpravkBKO/Oz++OKN7hw=
X-Google-Smtp-Source: AMsMyM6MquWjXJOKmnAYmrM6ObwgzTHvuvEwdhMPDyH6VEPj2zaiupN+l9i5FUXyv5UCCFWawBHXTmbHkkiHVjaVxDw=
X-Received: by 2002:a05:6a00:b84:b0:565:caea:38bc with SMTP id
 g4-20020a056a000b8400b00565caea38bcmr11316823pfj.80.1666223932014; Wed, 19
 Oct 2022 16:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEZ6=UNUcH2BvJj++OrT=XQLdkidU79wmCO=tantSOB36pPNTg@mail.gmail.com>
 <20221019174510.85286-1-sj@kernel.org>
In-Reply-To: <20221019174510.85286-1-sj@kernel.org>
From: Vinicius Petrucci <vpetrucci@gmail.com>
Date: Wed, 19 Oct 2022 18:58:15 -0500
Message-ID: <CAEZ6=UN4jagT49VHPr4oM0BSqUOybFyty85hrWKeKAq0QApSXA@mail.gmail.com>
Subject: Re: Issue while testing new fvaddr feature
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae!

I appreciate your feedback on this. Your explanation makes sense and I
didn't notice the "commit" feature. Sorry!

Nevertheless, I am still not able to get any perf data, and now I am
getting some errors. Not sure what I am doing wrong now. I tried both
approaches.

1) I tried doing =E2=80=9Con=E2=80=9D only after setting the start/end addr=
ess, and got:

# echo on > /sys/kernel/mm/damon/admin/kdamonds/0/state

-bash: echo: write error: Invalid argument

2) When doing =E2=80=9Con=E2=80=9D just after setting pid_target, then sett=
ing
start/end addr regions (as originally), then added a new echo =E2=80=9Ccomm=
it=E2=80=9D
to the state variable, the kdamond automatically goes to =E2=80=9Coff=E2=80=
=9D state
and cannot be set to "on" anymore. As follows:

# echo commit > /sys/kernel/mm/damon/admin/kdamonds/0/state

# cat /sys/kernel/mm/damon/admin/kdamonds/0/state

off

# echo on > /sys/kernel/mm/damon/admin/kdamonds/0/state

-bash: echo: write error: Invalid argument

Please let me know if you have any further directions on how to better
understand/debug this.

THanks again!
